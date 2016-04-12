public abstract class AbstractGUIElement implements GUIElemment {

    protected int m_x, m_y, m_height, m_width;

    public AbstractGUIElement(int x, int y, int width, int height) {
        this.m_x = x;
        this.m_y = y;
        this.m_width = width;
        this.m_height = height;
    }

    @Override
    public void setX(int x) {
        this.m_x = x;
    }

    @Override
    public void setY(int y) {
        this.m_y = y;
    }
 
    @Override
    public void setWidth(int width) {
        this.m_width = width;
    }

    @Override
    public void setHeight(int height) {
        this.m_height = height;
    }

    @Override
    public int getX() {
        return m_x;
    }


    @Override
    public int getY() {
        return m_y;
    }

    @Override
    public int getHeight() {
        return m_height;
    }

    @Override
    public int getWidth() {
        return m_width;
    }

    public boolean inBounds(int mouseX, int mouseY) {
        return mouseX > this.m_x && mouseX < this.m_x + this.m_width && mouseY > this.m_y && mouseY < this.m_y + this.m_height;
    }
}