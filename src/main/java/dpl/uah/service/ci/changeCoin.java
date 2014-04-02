/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dpl.uah.service.ci;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.ejb.Stateless;

/**
 *
 * @author pulgoso
 */
@WebService(serviceName = "changeCoin")
@Stateless()
public class changeCoin {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "cambiarDolaresEuros")
    public double cambiarDolaresEuros(@WebParam(name = "cantidad") double cantidad) {
        //TODO write your implementation code here:
        return cantidad / 1.5753;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "cambiarEurosDolares")
    public double cambiarEurosDolares(@WebParam(name = "cantidad") double cantidad) {
        //TODO write your implementation code here:
        return cantidad * 0.7247;
    }
}
