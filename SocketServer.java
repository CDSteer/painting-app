import java.net.*;
import java.util.*;
import java.awt.Color;
import java.io.*;

public class SocketServer {
    String value = "no value";
    ServerSocket sSoc = null;
    IsServerList list;
    public SocketServer() {
        list = new BasicServerList();
        try {
            sSoc = new ServerSocket(8888);
        } catch (IOException e) {
            e.printStackTrace();
        }
        servering();

    }
    public void servering(){
      try {
        Socket inSoc = sSoc.accept();
        ServerThread newServerThread = new ServerThread(inSoc,list,this);
        new Thread(newServerThread).start();
      } catch (IOException e) {
        System.out.println("IO Exception, continuing.");
        e.printStackTrace();
        }
      }

    public String getValue(){
        return this.value;
    }
    public void setValue(String v){
        this.value = v;
    }
}

class BasicServerList implements IsServerList {
    private Collection<IsServerThread> threadList;

    public BasicServerList() {
        threadList = new ArrayList<IsServerThread>();
    }

    public void add(IsServerThread item) {
        threadList.add(item);
    }

    // Similarly for removal.
    public void remove(IsServerThread item) {
        synchronized(threadList) {
            threadList.remove(item);
        }
    }

    // Don't need these for versions 1 and 2
    public void incCounter() {}
    public void decCounter() {}

    //This is because it would be too much effort to make this class implement
    //Collection, return it's own Iterator etc. etc...\
    //Note it is *not* a bug that it isn't synchronized
    public Collection getCollection() {
        return threadList;
    }
}

interface IsServerThread extends Runnable {
    void writeMessage(String string);
}

interface IsServerList {
    public void add(IsServerThread item);
    public void remove(IsServerThread item);
    public void incCounter();
    public void decCounter();
    public Collection getCollection();
}

class ServerThread implements IsServerThread {
    protected IsServerList threadList;
    private ObjectInputStream in;
    private ObjectOutputStream out;
    private String name;
    Socket inSocket;
    SocketServer m_SocketServer;

    public ServerThread(Socket inSoc, IsServerList list, SocketServer socket) throws IOException {
        m_SocketServer = socket;
        inSocket = inSoc;
        threadList = list;
        out = new ObjectOutputStream(inSoc.getOutputStream());
        out.flush();
        in = null;
        // Make sure we can only do this if no other thread is in a synchronized section
        synchronized (threadList) {
            threadList.add(this);
        }
    }

    //Write out to this thread's client
    public void writeMessage(String message) {
        if (message == null) {
            System.out.println("Null message");
        } else {
            try {
                out.writeObject(message);
            }
            catch (Exception e) {
                System.out.println("Failure writing message");
                e.printStackTrace();
            }
        }
    }
    public void run(){
        boolean notFinished = true;
        try {
            while (notFinished) {
                if (inSocket.getInputStream() != null) {
                    if (in == null) {
                        in = new ObjectInputStream(inSocket.getInputStream());
                    } else {
                        String m = in.readUTF();
                        m_SocketServer.setValue(m);
                    }
                }
            }
        } catch (IOException ie) {
            System.out.println("IO Exception");
            ie.printStackTrace();
        } finally {
            synchronized (threadList) {
                threadList.remove(this);
            }
        }
    }
}
