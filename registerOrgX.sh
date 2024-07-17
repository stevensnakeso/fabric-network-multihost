#!/bin/bash

source scriptUtils.sh

function createOrgX() {

  infoln "Enroll the CA admin"
  mkdir -p organizations/peerOrganizations/orgX.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/orgX.example.com/
  #  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
  #  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@ca.orgX.example.com:7054 --caname ca-orgX --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-orgX-example-com-7054-ca-orgX.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-orgX-example-com-7054-ca-orgX.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-orgX-example-com-7054-ca-orgX.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-orgX-example-com-7054-ca-orgX.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/orgX.example.com/msp/config.yaml

  infoln "Register peer0"
  set -x
  fabric-ca-client register --caname ca-orgX --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register peer1"
  set -x
  fabric-ca-client register --caname ca-orgX --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register peer2"
  set -x
  fabric-ca-client register --caname ca-orgX --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register user"
  set -x
  fabric-ca-client register --caname ca-orgX --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Register the org admin"
  set -x
  fabric-ca-client register --caname ca-orgX --id.name orgXadmin --id.secret orgXadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  mkdir -p organizations/peerOrganizations/orgX.example.com/peers
  mkdir -p organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com
  mkdir -p organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com
  mkdir -p organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com

  infoln "Generate the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/msp --csr.hosts peer0.orgX.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/msp/config.yaml

  infoln "Generate the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls --enrollment.profile tls --csr.hosts peer0.orgX.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/server.key

  infoln "Generate the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/msp --csr.hosts peer1.orgX.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/msp/config.yaml

  infoln "Generate the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls --enrollment.profile tls --csr.hosts peer1.orgX.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer1.orgX.example.com/tls/server.key

  infoln "Generate the peer2 msp"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/msp --csr.hosts peer2.orgX.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/msp/config.yaml

  infoln "Generate the peer2-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer2:peer2pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls --enrollment.profile tls --csr.hosts peer2.orgX.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer2.orgX.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/orgX.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/tlsca/tlsca.orgX.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/orgX.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/peers/peer0.orgX.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/orgX.example.com/ca/ca.orgX.example.com-cert.pem

  mkdir -p organizations/peerOrganizations/orgX.example.com/users
  mkdir -p organizations/peerOrganizations/orgX.example.com/users/User1@orgX.example.com

  infoln "Generate the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/users/User1@orgX.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgX.example.com/users/User1@orgX.example.com/msp/config.yaml

  mkdir -p organizations/peerOrganizations/orgX.example.com/users/Admin@orgX.example.com

  infoln "Generate the org admin msp"
  set -x
  fabric-ca-client enroll -u https://orgXadmin:orgXadminpw@ca.orgX.example.com:7054 --caname ca-orgX -M ${PWD}/organizations/peerOrganizations/orgX.example.com/users/Admin@orgX.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/orgX/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/orgX.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/orgX.example.com/users/Admin@orgX.example.com/msp/config.yaml

}
createOrgX
