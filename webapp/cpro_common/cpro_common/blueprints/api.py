from flask import Blueprint, render_template, make_response, jsonify, flash, redirect, url_for, request, current_app, Response, session
from cpro_common.models.cpro import Patient, MpowerUser
from ..auth import oauth, require_login, current_user


bp = Blueprint('api', __name__)

@bp.route('/Patient')
def patient():
    pdata = """
        <Patient xmlns="http://hl7.org/fhir"><birthDate value="1948-07-07" /><active value="true" /><gender value="M" /><deceasedBoolean value="false" /><id value="T81lum-5p6QvDR7l6hv7lfE52bAbA2ylWBnv9CZEzNb0B" /><careProvider><display value="Physician Family Medicine, MD" /><reference value="https://ic-fhirworks.epic.com/interconnect-fhirworks-oauth/api/FHIR/DSTU2/Practitioner/Thh97FZ9lU9.p-Rgpozo6vwB" /></careProvider><name><use value="usual" /><family value="Mychart" /><given value="Theodore" /><prefix value="MR." /></name><identifier><use value="usual" /><system value="urn:oid:1.2.840.114350.1.13.0.1.7.5.737384.0" /><value value="E2734" /></identifier><identifier><use value="usual" /><system value="urn:oid:1.2.840.114350.1.13.0.1.7.5.737384.14" /><value value="202500" /></identifier><identifier><use value="usual" /><system value="urn:oid:2.16.840.1.113883.4.1" /><extension url="http://hl7.org/fhir/StructureDefinition/rendered-value"><valueString value="xxx-xx-4199" /></extension></identifier><address><use value="home" /><line value="134 Elm Street" /><city value="Madison" /><state value="WI" /><postalCode value="53706" /><country value="US" /></address><telecom><system value="phone" /><value value="608-213-5806" /><use value="home" /></telecom><telecom><system value="phone" /><value value="608-272-5000" /><use value="work" /></telecom><maritalStatus><text value="Married" /></maritalStatus><communication><preferred value="true" /><language><text value="Sign Languages" /></language></communication><extension url="http://hl7.org/fhir/StructureDefinition/us-core-race"><valueCodeableConcept><text value="White" /><coding><system value="2.16.840.1.113883.5.104" /><code value="2106-3" /><display value="White" /></coding></valueCodeableConcept></extension><extension url="http://hl7.org/fhir/StructureDefinition/us-core-ethnicity"><valueCodeableConcept><text value="Unknown" /><coding><system value="2.16.840.1.113883.5.50" /><code value="UNK" /><display value="Unknown" /></coding></valueCodeableConcept></extension><extension url="http://hl7.org/fhir/StructureDefinition/us-core-birth-sex"><valueCodeableConcept><text value="Male" /><coding><system value="http://hl7.org/fhir/v3/AdministrativeGender" /><code value="M" /><display value="Male" /></coding></valueCodeableConcept></extension></Patient>
    """
    return Response(pdata, mimetype='text/xml')

@bp.route('/Patient/<int:id>')
def patient_new(id):
    pdata = """
        <Patient xmlns="http://hl7.org/fhir"><birthDate value="1948-07-07" /><active value="true" /><gender value="M" /><deceasedBoolean value="false" /><id value="T81lum-5p6QvDR7l6hv7lfE52bAbA2ylWBnv9CZEzNb0B" /><careProvider><display value="Physician Family Medicine, MD" /><reference value="https://ic-fhirworks.epic.com/interconnect-fhirworks-oauth/api/FHIR/DSTU2/Practitioner/Thh97FZ9lU9.p-Rgpozo6vwB" /></careProvider><name><use value="usual" /><family value="Mychart" /><given value="Theodore" /><prefix value="MR." /></name><identifier><use value="usual" /><system value="urn:oid:1.2.840.114350.1.13.0.1.7.5.737384.0" /><value value="E2734" /></identifier><identifier><use value="usual" /><system value="urn:oid:1.2.840.114350.1.13.0.1.7.5.737384.14" /><value value="202500" /></identifier><identifier><use value="usual" /><system value="urn:oid:2.16.840.1.113883.4.1" /><extension url="http://hl7.org/fhir/StructureDefinition/rendered-value"><valueString value="xxx-xx-4199" /></extension></identifier><address><use value="home" /><line value="134 Elm Street" /><city value="Madison" /><state value="WI" /><postalCode value="53706" /><country value="US" /></address><telecom><system value="phone" /><value value="608-213-5806" /><use value="home" /></telecom><telecom><system value="phone" /><value value="608-272-5000" /><use value="work" /></telecom><maritalStatus><text value="Married" /></maritalStatus><communication><preferred value="true" /><language><text value="Sign Languages" /></language></communication><extension url="http://hl7.org/fhir/StructureDefinition/us-core-race"><valueCodeableConcept><text value="White" /><coding><system value="2.16.840.1.113883.5.104" /><code value="2106-3" /><display value="White" /></coding></valueCodeableConcept></extension><extension url="http://hl7.org/fhir/StructureDefinition/us-core-ethnicity"><valueCodeableConcept><text value="Unknown" /><coding><system value="2.16.840.1.113883.5.50" /><code value="UNK" /><display value="Unknown" /></coding></valueCodeableConcept></extension><extension url="http://hl7.org/fhir/StructureDefinition/us-core-birth-sex"><valueCodeableConcept><text value="Male" /><coding><system value="http://hl7.org/fhir/v3/AdministrativeGender" /><code value="M" /><display value="Male" /></coding></valueCodeableConcept></extension></Patient>
    """
    return Response(pdata, mimetype='text/xml')


@bp.route('/metadata')
def metadata():
    conf_xml = """
        <Conformance xmlns="http://hl7.org/fhir">
        <rest>
        <mode value="server"/>
        <security>
        <cors value="true"/>
        <service>
        <text value="OAuth"/>
        <coding>
        <system value="http://hl7.org/fhir/ValueSet/restful-security-service"/>
        <code value="OAuth"/>
        <display value="OAuth"/>
        </coding>
        </service>
        <service>
        <text value="SMART-on-FHIR"/>
        <coding>
        <system value="http://hl7.org/fhir/ValueSet/restful-security-service"/>
        <code value="SMART-on-FHIR"/>
        <display value="SMART-on-FHIR"/>
        </coding>
        </service>
        <service>
        <text value="Basic"/>
        <coding>
        <system value="http://hl7.org/fhir/ValueSet/restful-security-service"/>
        <code value="Basic"/>
        <display value="Basic"/>
        </coding>
        </service>
        <extension url="http://fhir-registry.smarthealthit.org/StructureDefinition/oauth-uris">
        <extension url="authorize">
        <valueUri value="https://cpro.cirg.washington.edu/oauth2/authorize"/>
        </extension>
        <extension url="token">
        <valueUri value="https://cpro.cirg.washington.edu/oauth2/token"/>
        </extension>
        </extension>
        </security>
        </rest>
        </Conformance>
        """
    return Response(conf_xml, mimetype='text/xml')
