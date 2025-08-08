unit Licensing;

interface

// Developer ///////////////////////////////////////////////////////////////////

type
  TProductDeveloper = (
    pdAdvik,
    pdBitRecover,
    pdRecoveryTools,
    pdTurgs
  );

  TDeveloperInfo = record
    Name: String;
    Homepage: String;
  end;

const
  DeveloperList: array[TProductDeveloper] of TDeveloperInfo = (
    (
      Name: 'Advik';
      Homepage: 'http://www.adviksoft.com';
    ),
    (
      Name: 'BitRecover';
      Homepage: 'https://www.bitrecover.com';
    ),
    (
      Name: 'RecoveryTools';
      Homepage: 'http://www.recoverytools.com';
    ),
    (
      Name: 'Turgs';
      Homepage: 'https://turgs.com';
    )
  );

// License /////////////////////////////////////////////////////////////////////

type
  TLicenseType = (ltStandard, ltProCorporate, ltEnterpriseMigration);
  TLicenseTypes = set of TLicenseType;

const
  LicenseList: array[TLicenseType] of String = (
    'Standard',
    'Pro/Corporate',
    'Enterprise/Migration'
  );

// Products ////////////////////////////////////////////////////////////////////

type  
  TProductInfo = record
    Developer: TProductDeveloper;
    Name: String;
    ProductCode: Word;
    CodePage: Word;
    SupportedLicenses: TLicenseTypes;
  end;

const
  ProductCount = 151;
  ProductList: array[0..ProductCount - 1] of TProductInfo = (
    // Advik Products //////////////////////////////////////////////////////////

    (
      Developer: pdAdvik;
      Name: 'Aadhaar Card Password Remover';
      ProductCode: $01BF;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'AOL Backup';
      ProductCode: $0184;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'EarthLink Backup';
      ProductCode: $01CA;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to CSV Export';
      ProductCode: $01A2;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to DOC Export';
      ProductCode: $019E;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to Gmail Import';
      ProductCode: $01A6;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to HTML Export';
      ProductCode: $019D;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to MSG Export';
      ProductCode: $01A1;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to OLM Export';
      ProductCode: $01E7;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to PDF Export';
      ProductCode: $019F;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to PST Export';
      ProductCode: $01A0;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to TXT Export';
      ProductCode: $019C;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'EML to Yahoo Import';
      ProductCode: $01AD;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Gmail Backup';
      ProductCode: $017C;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'GMX Backup';
      ProductCode: $01CC;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to DOC Export';
      ProductCode: $0177;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to EML Export';
      ProductCode: $017A;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to Gmail Import';
      ProductCode: $01AB;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to HTML Export';
      ProductCode: $0176;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to MSG Export';
      ProductCode: $017B;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to PDF Export';
      ProductCode: $0178;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to PST Export';
      ProductCode: $0179;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to TXT Export';
      ProductCode: $0175;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Google Takeout to Yahoo Import';
      ProductCode: $01B2;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Mass Delete Gmail Messages';
      ProductCode: $018C;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX Converter Toolkit';
      ProductCode: $01D4;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];  //Pro, Toolkit
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to DOC Export';
      ProductCode: $0170;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to EML Export';
      ProductCode: $0173;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to Gmail Import';
      ProductCode: $01AA;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to HTML Export';
      ProductCode: $016F;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to MSG Export';
      ProductCode: $0174;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to PDF Export';
      ProductCode: $0171;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to PST Export';
      ProductCode: $0172;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to TXT Export';
      ProductCode: $016E;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MBOX to Yahoo Import';
      ProductCode: $01B1;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MDaemon to DOC Export';
      ProductCode: $01C3;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MDaemon to HTML Export';
      ProductCode: $01C2;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MDaemon to Office 365 Export';
      ProductCode: $01C0;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MDaemon to PST Export';
      ProductCode: $01C5;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MDaemon to TXT Export';
      ProductCode: $01C1;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to CSV Export';
      ProductCode: $019B;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to DOC Export';
      ProductCode: $0197;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to EML Export';
      ProductCode: $019A;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to Gmail Import';
      ProductCode: $01A7;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to HTML Export';
      ProductCode: $0196;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to PDF Export';
      ProductCode: $0198;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to PST Export';
      ProductCode: $0199;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to TXT Export';
      ProductCode: $0195;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'MSG to Yahoo Import';
      ProductCode: $01AE;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Office 365 Backup';
      ProductCode: $0180;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to CSV Export';
      ProductCode: $0194;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to DOC Export';
      ProductCode: $018F;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to EML Export';
      ProductCode: $0192;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to Gmail Import';
      ProductCode: $01AC;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to HTML Export';
      ProductCode: $018E;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to ICS Export';
      ProductCode: $01B4;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to MSG Export';
      ProductCode: $0193;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to PDF Export';
      ProductCode: $0190;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to PST Export';
      ProductCode: $0191;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to Thunderbird Export';
      ProductCode: $01A4;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to TXT Export';
      ProductCode: $018D;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to Yahoo Import';
      ProductCode: $01B3;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to vCard Export';
      ProductCode: $01DA;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OLM to Zimbra Export';
      ProductCode: $01A3;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OST to Gmail Import';
      ProductCode: $01A9;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'OST to Yahoo Import';
      ProductCode: $01B0;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Outlook.com Backup';
      ProductCode: $0182;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'PST to Gmail Import';
      ProductCode: $01A8;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'PST to Yahoo Import';
      ProductCode: $01AF;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdAdvik;
      Name: 'Rackspace Backup';
      ProductCode: $01CE;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'Rediffmail Backup';
      ProductCode: $018A;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'WorkMail Backup';
      ProductCode: $01D0;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'Yahoo Backup';
      ProductCode: $017E;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdAdvik;
      Name: 'Yandex Backup';
      ProductCode: $0186;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),

    // BitRecover Products /////////////////////////////////////////////////////
    
    (
      Developer: pdBitRecover;
      Name: 'Backup Recovery Wizard';
      ProductCode: $004B;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'BAT Converter Wizard';
      ProductCode: $0034;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Data Recovery Wizard';
      ProductCode: $0042;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'EML Converter Wizard';
      ProductCode: $0062;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'EML to PST Wizard';
      ProductCode: $003C;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'IncrediMail Converter Wizard';
      ProductCode: $0076;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Lock PDF Wizard';
      ProductCode: $003A;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'MBOX Converter Wizard';
      ProductCode: $0045;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'MSG to PST Wizard';
      ProductCode: $003E;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'OST Converter Wizard';
      ProductCode: $012D;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdBitRecover;
      Name: 'OST Repair Wizard';
      ProductCode: $013D;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Parallels HDD Recovery Wizard';
      ProductCode: $004C;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Pen Drive Recovery Wizard';
      ProductCode: $0050;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'PST Converter Wizard';
      ProductCode: $0047;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'PST Password Recovery Wizard';
      ProductCode: $0059;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'PST Repair Wizard';
      ProductCode: $013A;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdBitRecover;
      Name: 'PST Unlock Wizard';
      ProductCode: $0022;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Thunderbird Backup Wizard';
      ProductCode: $0031;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Thunderbird Converter Wizard';
      ProductCode: $0032;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Unlock PDF';
      ProductCode: $005D;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'VDI Recovery Wizard';
      ProductCode: $004A;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'VHD Recovery Wizard';
      ProductCode: $005A;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Virtual Drive Recovery Wizard';
      ProductCode: $0056;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'VMDK Recovery Wizard';
      ProductCode: $0049;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'VMFS Recovery Wizard';
      ProductCode: $0055;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdBitRecover;
      Name: 'Windows Live Mail Converter Wizard';
      ProductCode: $0066;
      CodePage: 0;
      SupportedLicenses: [];
    ),

    // RecoveryTools Products //////////////////////////////////////////////////

    (
      Developer: pdRecoveryTools;
      Name: 'DOCX Migrator';
      ProductCode: $0169;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'Email Backup Wizard';
      ProductCode: $01D6;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'EMLX Migrator';
      ProductCode: $0122;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'MailMigra for Pegasus';
      ProductCode: $0041;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'MBOX Migrator';
      ProductCode: $0135;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'MSG Migrator';
      ProductCode: $0125;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'nMigrator';
      ProductCode: $00D5;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'OLM Migrator';
      ProductCode: $0116;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdRecoveryTools;
      Name: 'zMigrator';
      ProductCode: $00D2;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),

    // Turgs Products //////////////////////////////////////////////////////////

    (
      Developer: pdTurgs;
      Name: 'Backupify Wizard';
      ProductCode: $00CA;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'DBX Wizard';
      ProductCode: $00B2;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'eM Wizard';
      ProductCode: $00B4;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'eMClient to NSF Wizard';
      ProductCode: $00E0;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'EML to NSF Wizard';
      ProductCode: $00DE;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'EML to Office 365 Wizard';
      ProductCode: $0104;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'EML Wizard';
      ProductCode: $00B4;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Eudora Wizard';
      ProductCode: $00C6;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'gBackup Wizard';
      ProductCode: $010C;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'gTakeout Wizard';
      ProductCode: $00CC;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'IncrediMail Wizard';
      ProductCode: $0043;
      CodePage: 0;
      SupportedLicenses: [];
    ),
    (
      Developer: pdTurgs;
      Name: 'Mac Mail Wizard';
      ProductCode: $00CE;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Maildir to NSF Wizard';
      ProductCode: $00E4;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Maildir Wizard';
      ProductCode: $00BD;
      CodePage: 3;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdTurgs;
      Name: 'MBOX Merge Wizard';
      ProductCode: $00BE;
      CodePage: 3;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdTurgs;
      Name: 'MBOX to Maildir Wizard';
      ProductCode: $00C3;
      CodePage: 3;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdTurgs;
      Name: 'MBOX to NSF Wizard';
      ProductCode: $00DC;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'MBOX to Office 365 Wizard';
      ProductCode: $0108;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'MBOX Wizard';
      ProductCode: $00B0;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'MHT Wizard';
      ProductCode: $00B8;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'MSG Contacts Wizard';
      ProductCode: $00BC;
      CodePage: 3;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdTurgs;
      Name: 'MSG to Office 365 Wizard';
      ProductCode: $0106;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'MSG Wizard';
      ProductCode: $00B6;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'NSF to Maildir Wizard';
      ProductCode: $00EC;
      CodePage: 3;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdTurgs;
      Name: 'NSF Wizard';
      ProductCode: $00DA;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'MSG to NSF Wizard';
      ProductCode: $00E6;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'O365 Backup Wizard';
      ProductCode: $0112;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'OST to NSF Wizard';
      ProductCode: $00D8;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'OST to Office 365 Wizard';
      ProductCode: $0102;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'OST Wizard';
      ProductCode: $00AE;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'PST Contacts Wizard';
      ProductCode: $00BF;
      CodePage: 3;
      SupportedLicenses: [ltStandard];
    ),
    (
      Developer: pdTurgs;
      Name: 'PST to NSF Wizard';
      ProductCode: $00D8;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'PST to Office 365 Wizard';
      ProductCode: $0102;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'PST Wizard';
      ProductCode: $00AE;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Thunderbird to NSF Wizard';
      ProductCode: $00E2;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Thunderbird Wizard';
      ProductCode: $00C4;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'vCard Wizard';
      ProductCode: $00BA;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'yBackup Wizard';
      ProductCode: $010E;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'ZDB Wizard';
      ProductCode: $00E8;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Zimbra MSG Wizard';
      ProductCode: $00EA;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    ),
    (
      Developer: pdTurgs;
      Name: 'Zimbra Wizard';
      ProductCode: $0148;
      CodePage: $FDE9;
      SupportedLicenses: [ltStandard, ltProCorporate, ltEnterpriseMigration];
    ),
    (
      Developer: pdTurgs;
      Name: 'Zoho Backup Wizard';
      ProductCode: $0114;
      CodePage: 3;
      SupportedLicenses: [ltStandard, ltProCorporate];
    )
  );

function GenerateLicenseKey(const ProductInfo: TProductInfo;
  const LicenseType: TLicenseType; const EMail: String): String;

implementation

uses
  Windows,
  MD5,
  SysUtils;

//------------------------------------------------------------------------------

function WSToMBS(CodePage: LongWord; const S: WideString): AnsiString;
var
  Len: Integer;
begin
  Len := WideCharToMultiByte(CodePage, 0, PWideChar(S), Length(S), nil, 0, nil, nil);
  SetLength(Result, Len);
  WideCharToMultiByte(CodePage, 0, PWideChar(S), Length(S), PChar(@Result[1]), Len, nil, nil);
end;

//------------------------------------------------------------------------------

function GenerateLicenseKey(const ProductInfo: TProductInfo;
  const LicenseType: TLicenseType; const EMail: String): String;
var
  S1: WideString;
  S2: String;
  I: Integer;
begin
  if LicenseType in ProductInfo.SupportedLicenses then
  begin
    // Convert email from ANSI to UNICODE.
    S1 := UTF8Decode(EMail);

    // XOR encoding with the product code (incremented with the license type value).
    for I := 1 to Length(S1) do
      S1[I] := WideChar(Word(S1[I]) xor (ProductInfo.ProductCode + Word(LicenseType)));

    // Convert the encoded string back to ANSI using an special code page, then
    // calculate and return the MD5 hash of that resulting string (the final key).
    Result := MD5ToString(MD5FromString(WSToMBS(ProductInfo.CodePage, S1)));
  end
  else
  begin
    // XOR encode the email with the product code.
    S2 := EMail;

    for I := 1 to Length(S2) do
      S2[I] := Char(Byte(S2[I]) xor Byte(ProductInfo.ProductCode));

    // Calculate and return the MD5 hash of the encoded email (the final key).
    Result := MD5ToString(MD5FromString(S2));
  end;
end;

end.
