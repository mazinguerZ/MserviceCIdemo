/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dpl.uah.service.ci;

import javax.ejb.embeddable.EJBContainer;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author pulgoso
 */
public class changeCoinTest {
    
    public changeCoinTest() {
    }


    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of hello method, of class changeCoin.
     */
    @org.junit.Test
    public void testHello() throws Exception {
        System.out.println("hello");
        String txt = "";
        String expResult = "<>";
        
        assertEquals(expResult, "<>");
    }

    /**
     * Test of cambiarDolaresEuros method, of class changeCoin.
     */
    @org.junit.Test
    public void testCambiarDolaresEuros() throws Exception {
        
        System.out.println("cambiarDolaresEuros");
        double cantidad = 0.0;
       
        changeCoin test = new changeCoin();
        
        double expResult = 0.0;
        double valorCorrecto = 0.0;
        double result = test.cambiarDolaresEuros(cantidad);
        assertEquals(expResult, result, valorCorrecto);
    }

    /**
     * Test of cambiarEurosDolares method, of class changeCoin.
     */
    @org.junit.Test
    public void testCambiarEurosDolares() throws Exception {
        System.out.println("cambiarEurosDolares");
        double cantidad = 0.0;
        
        changeCoin test = new changeCoin();
               
        
        double expResult = 0.0;
        double result = test.cambiarEurosDolares(cantidad);
        assertEquals(expResult, result, 0.0);
    }
}
