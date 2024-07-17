#!/bin/bash

source scriptUtils.sh

function createOrgE() {

  infoln "Enroll the CA admin"
  mkdir -p organizations/peerOrganizations/orgE.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/orgE.example.com/
  #  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
  #  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@ca.orgE.example.com:7054 --caname ca-orgE --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orgE-example-com-7054-ca-orgE.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orgE-example-com-7054-ca-orgE.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orgE-example-com-7054-ca-orgE.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orgE-example-com-7054-ca-orgE.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/orgE.example.com/msp/config.yaml

  infoln "Register peer0"
  set -x
  fabric-ca-client register --caname ca-orgE --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register peer1"
  set -x
  fabric-ca-client register --caname ca-orgE --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register peer2"
  set -x
  fabric-ca-client register --caname ca-orgE --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register user"
  set -x
  fabric-ca-client register --caname ca-orgE --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register the org admin"
  set -x
  fabric-ca-client register --caname ca-orgE --id.name orgEadmin --id.secret orgEadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  mkdir -p organizations/peerOrganizations/orgE.example.com/peers
  mkdir -p organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com
  mkdir -p organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com
  mkdir -p organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com

  infoln "Generate the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/msp --csr.hosts peer0.orgE.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/msp/config.yaml

  infoln "Generate the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls --enrollment.profile tls --csr.hosts peer0.orgE.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/server.key

  infoln "Generate the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/msp --csr.hosts peer1.orgE.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/msp/config.yaml

  infoln "Generate the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls --enrollment.profile tls --csr.hosts peer1.orgE.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer1.orgE.example.com/tls/server.key

  infoln "Generate the peer2 msp"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/msp --csr.hosts peer2.orgE.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/msp/config.yaml

  infoln "Generate the peer2-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls --enrollment.profile tls --csr.hosts peer2.orgE.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer2.orgE.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/orgE.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/tlsca/tlsca.orgE.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/orgE.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/peers/peer0.orgE.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/orgE.example.com/ca/ca.orgE.example.com-cert.pem

  mkdir -p organizations/peerOrganizations/orgE.example.com/users
  mkdir -p organizations/peerOrganizations/orgE.example.com/users/User1@orgE.example.com

  infoln "Generate the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/users/User1@orgE.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgE.example.com/users/User1@orgE.example.com/msp/config.yaml

  mkdir -p organizations/peerOrganizations/orgE.example.com/users/Admin@orgE.example.com

  infoln "Generate the org admin msp"
  set -x
  fabric-ca-client enroll -u https://orgEadmin:orgEadminpw@ca.orgE.example.com:7054 --caname ca-orgE -M ${PWD}/organizations/peerOrganizations/orgE.example.com/users/Admin@orgE.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orgE/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgE.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgE.example.com/users/Admin@orgE.example.com/msp/config.yaml

}
createOrgE
