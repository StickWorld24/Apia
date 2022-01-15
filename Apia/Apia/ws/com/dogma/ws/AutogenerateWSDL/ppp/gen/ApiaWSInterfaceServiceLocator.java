/**
 * ApiaWSInterfaceServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.dogma.ws.AutogenerateWSDL.ppp.gen;

public class ApiaWSInterfaceServiceLocator extends org.apache.axis.client.Service implements com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSInterfaceService {

    public ApiaWSInterfaceServiceLocator() {
    }


    public ApiaWSInterfaceServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ApiaWSInterfaceServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for ApiaWSppp
    private java.lang.String ApiaWSppp_address = "http://localhost:8282/Dogma2.0/services/ApiaWSppp";

    public java.lang.String getApiaWSpppAddress() {
        return ApiaWSppp_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ApiaWSpppWSDDServiceName = "ApiaWSppp";

    public java.lang.String getApiaWSpppWSDDServiceName() {
        return ApiaWSpppWSDDServiceName;
    }

    public void setApiaWSpppWSDDServiceName(java.lang.String name) {
        ApiaWSpppWSDDServiceName = name;
    }

    public com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSInterface getApiaWSppp() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ApiaWSppp_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getApiaWSppp(endpoint);
    }

    public com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSInterface getApiaWSppp(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSSoapBindingStub _stub = new com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSSoapBindingStub(portAddress, this);
            _stub.setPortName(getApiaWSpppWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setApiaWSpppEndpointAddress(java.lang.String address) {
        ApiaWSppp_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSInterface.class.isAssignableFrom(serviceEndpointInterface)) {
                com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSSoapBindingStub _stub = new com.dogma.ws.AutogenerateWSDL.ppp.gen.ApiaWSSoapBindingStub(new java.net.URL(ApiaWSppp_address), this);
                _stub.setPortName(getApiaWSpppWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("ApiaWSppp".equals(inputPortName)) {
            return getApiaWSppp();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.apiasolutions.com/WebServices", "ApiaWSInterfaceService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.apiasolutions.com/WebServices", "ApiaWSppp"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("ApiaWSppp".equals(portName)) {
            setApiaWSpppEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
