class Member {
  int id;
  Client clientInfo;
  String memberNumber;
  String subscriberNumber;
  Demographic demographic;
  ContactInfo contactInfo;
  Location location;
  MedicaidInfo medicaidInfo;

  Member({
    this.id,
    this.clientInfo,
    this.memberNumber,
    this.subscriberNumber,
    this.demographic,
    this.contactInfo,
    this.location,
    this.medicaidInfo
  });

  factory Member.fromJson(Map<String, dynamic> memberJson) {
    return Member(
      id: memberJson['id'],
      clientInfo: Client.fromJson(memberJson['client']),
      memberNumber: memberJson['member_number'],
      subscriberNumber: memberJson['subscriber_number'],
      demographic: Demographic.fromJson(memberJson['demographic']),
      contactInfo: ContactInfo.fromJson(memberJson['contact_info']),
      location: Location.fromJson(memberJson['location']),
      medicaidInfo: MedicaidInfo.fromJson(memberJson['medicaid_info']),
    );
  }
}

class Client {
  int id;
  String clientName;
  String clientAddressOne;
  String clientAddressTwo;
  String clientState;
  String clientZip;
  String clientPhoneOne;
  String clientPhoneTwo;

  Client({this.id, this.clientName, this.clientAddressOne, this.clientAddressTwo, this.clientState, this.clientZip, this.clientPhoneOne, this.clientPhoneTwo});

  factory Client.fromJson(Map<String, dynamic> clientJson) {
    return Client(
      id: clientJson['id'],
      clientName: clientJson['client_name'],
      clientAddressOne: clientJson['client_address_1'],
      clientAddressTwo: clientJson['client_address_2'],
      clientState: clientJson['client_state'],
      clientZip: clientJson['client_zip'],
      clientPhoneOne: clientJson['client_phone_1'],
      clientPhoneTwo: clientJson['client_phone_2'],
    );
  }
}

class Demographic {
  String firstName;
  String lastName;
  String middleName;
  String nameSuffix;
  String gender;
  String dateOfBirth;

  Demographic({this.firstName, this.lastName, this.middleName, this.nameSuffix, this.gender, this.dateOfBirth});

  factory Demographic.fromJson(Map<String, dynamic> demographicJson) {
    return Demographic(
      firstName: demographicJson['first_name'],
      lastName: demographicJson['last_name'],
      middleName: demographicJson['middle_name'],
      nameSuffix: demographicJson['first_name'],
      gender: demographicJson['gender'],
      dateOfBirth: demographicJson['date_of_birth'],
    );
  }
}

class ContactInfo {
  String primaryPhoneNumber;
  String secondaryPhoneNumber;
  String emailAddress;

  ContactInfo({this.primaryPhoneNumber, this.secondaryPhoneNumber, this.emailAddress});

  factory ContactInfo.fromJson(Map<String, dynamic> contactInfoJson) {
    return ContactInfo(
      primaryPhoneNumber: contactInfoJson['primary_phone_number'],
      secondaryPhoneNumber: contactInfoJson['secondary_phone_number'],
      emailAddress: contactInfoJson['email_address'],
    );
  }
}

class Location {
  String streetAddressOne;
  String streetAddressTwo;
  String addressCity;
  String addressState;
  String addressZip;

  Location({this.streetAddressOne, this.streetAddressTwo, this.addressCity, this.addressState, this.addressZip});

  factory Location.fromJson(Map<String, dynamic> locationJson) {
    return Location(
      streetAddressOne: locationJson['street_address_1'],
      streetAddressTwo: locationJson['street_address_2'],
      addressCity: locationJson['address_city'],
      addressState: locationJson['address_state'],
      addressZip: locationJson['address_zip'],
    );
  }
}

class MedicaidInfo {
  String medicaidId;
  String medicaidState;
  String groupCoverageCode;
  String subGroupCoverageCode;
  MemberPlan memberPlan;
  String lineOfBusiness;
  String eligibilityStartDate;
  String eligibilityEndDate;
  String assignedProvider;
  String coverageLevel;
  String cardHolderId;
  String ssn;
  String decreasedDate;
  String vipIndicator;
  String memberRiskScore;
  String employeeOrganizationIdentifier;
  String personNumber;
  String memberRelationToSubscriber;

  MedicaidInfo({
    this.medicaidId,
    this.medicaidState,
    this.groupCoverageCode,
    this.subGroupCoverageCode,
    this.memberPlan,
    this.lineOfBusiness,
    this.eligibilityStartDate,
    this.eligibilityEndDate,
    this.assignedProvider,
    this.coverageLevel,
    this.cardHolderId,
    this.ssn,
    this.decreasedDate,
    this.vipIndicator,
    this.memberRiskScore,
    this.employeeOrganizationIdentifier,
    this.personNumber,
    this.memberRelationToSubscriber
  });

  factory MedicaidInfo.fromJson(Map<String, dynamic> medicaidInfoJson) {
    return MedicaidInfo(
      medicaidId: medicaidInfoJson['member_medicaid_id'],
      medicaidState: medicaidInfoJson['member_medicaid_state'],
      groupCoverageCode: medicaidInfoJson['member_group_coverage_code'],
      subGroupCoverageCode: medicaidInfoJson['member_sub_group_coverage_code'],
      memberPlan: MemberPlan.fromJson(medicaidInfoJson['member_plan']),
      lineOfBusiness: medicaidInfoJson['line_of_business'],
      eligibilityStartDate: medicaidInfoJson['eligibility_start_date'],
      eligibilityEndDate: medicaidInfoJson['eligibility_end_date'],
      assignedProvider: medicaidInfoJson['assigned_provider'],
      coverageLevel: medicaidInfoJson['coverage_level'],
      cardHolderId: medicaidInfoJson['card_holder_id'],
      ssn: medicaidInfoJson['ssn'],
      decreasedDate: medicaidInfoJson['deceased_date'],
      vipIndicator: medicaidInfoJson['vip_indicator'],
      memberRiskScore: medicaidInfoJson['member_risk_Score'],
      employeeOrganizationIdentifier: medicaidInfoJson['employee_organization_identifier'],
      personNumber: medicaidInfoJson['person_number'],
      memberRelationToSubscriber: medicaidInfoJson['member_relation_to_subscriber'],
    );
  }
}

class MemberPlan {
  String planName;
  String planCode;

  MemberPlan({this.planName, this.planCode});

  factory MemberPlan.fromJson(Map<String, dynamic> memberPlanJson) {
    return MemberPlan(
      planName: memberPlanJson['plan_name'],
      planCode: memberPlanJson['plan_code']
    );
  }
}