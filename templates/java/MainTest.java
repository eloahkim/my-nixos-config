package @PACKAGE@;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class MainTest {
    @Test
    void soma() {
        assertEquals(5, Main.soma(2, 3));
    }
}
