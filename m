Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310CC004C0
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U040m0QeYJT/QK2r+yiWjaxedoWipbaj9lg6e5w2dH8=; b=igh2myPbUDOvtM
	kBMsgpP/ce6U9YlUteDlD9VwusY40UzvDC7UljU63Q98E+hYn0Nfq38AJJP1mGf2WKnCe/KBKSB6h
	0iQnP5C/qubByBIY2OMQoMRUGRWip6YyP5yJXY0ZjUSYd5OjHPTFK/ytQaq/5qgeiDYaCHMV4Dzya
	drmGBVK6UvvLoQKPLWqBBmYBnUGnC+AWgDa1Opxy3b/QfH1PmAYCWUd45Nc2j6EkeTWjJQWxm21XE
	OgExNeHp8LKXKaR357JqdLyS8MdnDwXTas8rIxBzws0dne5rOG3jIlUSQm9DQgbkPPx6gvVyTD8lK
	ENZ8bbFc+iHnmepuQr6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtli3-001fcc-1A;
	Fri, 20 Oct 2023 09:22:23 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtli0-001fb3-2g
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 09:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793740; x=1729329740;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TqqSqvxGgaA7ur9Wt86j29F82tEcjiTSCY/9DmzPSFk=;
  b=df7FR8iuzLX99IgPEzMJs2ZVHqSoNHCiEZnMmBfF9P3E3GUHYI81Iial
   Nv0RGTMB8Rzc2bz4T0noT2xDnuK1xJPQb9ysRzRST4KgeNJm+U6SfE1Ev
   THfeWo2nwR6Fw/WARKnbyc9XV9IDtewjYdJv8c+rFlGoMHFSPRL2CC5xg
   bT7Dk9rfvCV3xw9owYdD7Sf0WxbiFf8OoFdFECR9i3uq1Rk5Upu7xlc/Q
   L/h1Sj3HiE34lAph1WL3a38LrhzDJJeossezoS09PP9JCQ85gIC52JlY2
   g8kKWAfvLHB/DGYFo8xwfxFActFsNbSf/811nNOqRYdyRTKnkwYGvNzuJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390347404"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="390347404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="823180580"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="823180580"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 02:22:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 02:22:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONpRncANEaucK1Gh8PBtKKJYD5mBQDGeYa9CnmKmjDZfPRLjIZ7gJ/NWzwLtg9Bjo691irMWhM9D2J2zwM/0WTllGwrcM7cCABVk+fmzk8GNLCbwKq/fTX4SJJlRnQ8qVjBDrvgohTdy7kkYYRNLem/IhJK2EF9OsK8ng9ag1D5MkwZPaWvcM1Bpos43qecGpsGs3azdO0/WeOwRtO0VD8pj56o/X4Jq5orDVNGdOz8EBLyv4TEC5P67PkM4yBBYagQR5K9NNzouo01sv0UcrCAQelGEGXYHyISR7O5RFcWJEgKWOU0SrXxwkZihUI42UBcG9+kn1gOl21MmXL5UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt/pVCV0GyRmBJOdKR3vsgLyS9rnL1K4dIwfJmQw6wE=;
 b=fu22fP4R4Vxd1Tv5Bjzg7MK9hTgJSWAOKEZAJ1ha5glSXhnLUKnJXiu5udrw6NVENtS237eoI3pTBRNFIcXAf+liA68gp+FI0z0lc8LsgKqG9ReKvWVvpe8NLScIW2bXcM8DGuvSaiSCo7KvjYAZouxaOLMmtTJMIR7ntkLNtb88FJxXv6aWEuk2kOTIeXOzWQiF+o5PxS7QvOoYMdRhYkUiLBsgzG6RZFm3L+zKSrOI4js0O6iPj2nU+cWaiWmu+do68UaJJkej1zOXC85yXIh/V4UPtAgxyowRwr7mdAqplGuU78VCcLbe7o0v7q3vSIp7/HEdPOEdr6hh2XNejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 09:22:08 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::cc5d:d2c9:b39a:3de7]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::cc5d:d2c9:b39a:3de7%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 09:22:07 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: <llvm@lists.linux.dev>, <linux-um@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<linux-kselftest@vger.kernel.org>
CC: Tom Rix <trix@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, "David
 Gow" <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH 0/2] um: kunit: Add Clang support for CONFIG_GCOV
Date: Fri, 20 Oct 2023 11:21:57 +0200
Message-ID: <20231020092159.2486063-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.42.0
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|PH8PR11MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b6f9f3-586a-4881-77e9-08dbd14e0782
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVW0Tu0XVheuAmFhubeVhitTX5w8wQNehBkesOSXdK8CCekpTN6R5lPKuX1hK9/joOS3z/Ue+Z5KWonWDYQ2WI0glu34rDTev2oyEFaxXC+c9HdZCcuBMj8DOfrcMk9SoTD7lLOLtpAT06AZNWrHvphT8TTxv9PVNlOWtRyt+Dju63ypcqPI+7dlt0259GYHIvqn6PyvGOn6j+d822ixO85nAx4cwsI8QrDrLlu9bNC2imDgenSN8jow/j/fkeaoX7t/UxWejEeRoYL9+/8kBCGjXSKxWU5N+tT6yxAmH3SOJNcx74iMVMmZDpVMEowKlqJN94hDWr6mf5bjFtZZEaRZ4VRUZxXEyTmOJjKLv8NMNxKyDuYim5EiVCrdEl6tWUOri0aQceNoDnuZhsuBsvebh4IxjZtXdyCF5PmAFvq6QSRJWbHiKYk9EkJGHalAEJ+csmdNOdGHkU7hQ3+hOtaCcpPDH67UFvdoDM2dHyx5mcyjxKt+6OWUntlMl74v2zAWAShNYeyama/oI9+mQC1crSyntNOi6tGO0ntWykdMWEj2enmUGzKattdSCUFk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(82960400001)(36756003)(86362001)(4744005)(7416002)(26005)(478600001)(83380400001)(6506007)(6486002)(316002)(2616005)(1076003)(6512007)(8676002)(4326008)(107886003)(8936002)(41300700001)(6666004)(54906003)(66946007)(66556008)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNsek5tdkNCckF0UVhrRVRIdVNDZ3pzeWxqYWhwU1NOajQwM1FzMWpIMUto?=
 =?utf-8?B?aHkwTkl6c3dheXRYdUJpWVJTUFFzaEc1bGZ0YnBjUmhJbFZWblpxTHk5cmhL?=
 =?utf-8?B?NXNlTVR2ZXc4NWhDd0dlZVMwYlZYcnhLaTFiSEZEQmRjSklPTmhML1IvWmZO?=
 =?utf-8?B?NHNDTysxckxIaG9qbmJpNHlZL2dEbnpUbjlzalRHZFlzc1lDQWdlRlgxTHFq?=
 =?utf-8?B?VWtsZ1k2cjJCWldqc0N3WnViamI0Y3ArRmxYYWRQdGhuc2haMDRYcHBoNTJs?=
 =?utf-8?B?UjlTZHBDOVF4Z2cxWkJFMk9zd0FQWTJLZzVKV294R1FyYk9CbEY3dUtuTzY1?=
 =?utf-8?B?enFMR0Ixb2NRWCtJTkNUNTN4TkJ6d2tqSDNkb0pHQmUwMWVERUxGVVZBK2No?=
 =?utf-8?B?eVVUazZaM0x0MHphWkMxM0lpT2hicGxaU1E4M1gzMmFwUjVaRFZyam1MZEhF?=
 =?utf-8?B?dnFqaW0veSt5ZjZ5eFYyUUYxdlNLVWszU2lmZWVmTzUxcFU2dFJ0MVFlSDNs?=
 =?utf-8?B?Mk9uK0h0S2RVbzY5K2NPTU9US2doc3FRMTRwT3R1RjJzL2dqV0NHSVJyMEtB?=
 =?utf-8?B?WW8yeGRFN2dPT2Q5VmowS3NobzAxNFV3eUVvMWtWZmZOL3d3ZWo2ZzhHQXBV?=
 =?utf-8?B?NVJDbE5NWU9WbTdLMVJ5U0ZjRFpIYURwUXZ1QnBmNXRBMUtoU1BFaWdZT2dw?=
 =?utf-8?B?OCs4eXlIS0xtZERGSEt6S1g2SlduM2V1WVZ1UkYveFBVWjBHMitybWcwMFJZ?=
 =?utf-8?B?R3UwME9zSkNyeHcvSVhCaEtMZzRXeVg0S0JzNFFrSEFodnp2MERrblFxODZT?=
 =?utf-8?B?Lzg5dmdlR0dpeE92eHpmcEV2YWV5K3RtNk1oYnk5NHkxaU9lM1U4cFNmV3N2?=
 =?utf-8?B?bHUrdjRMZnJZK0FhdXdZNTJJalN3OEpxbmphNmphanBxQ3dFOHFxcXgvNU1u?=
 =?utf-8?B?Tld2VUh3T2JOL0hrd3R1ZFRxL2JEYnRYQ0VuS3VWUkRhY2c3M0VvTEdTbU42?=
 =?utf-8?B?OXJ2b2VNNTZmdGVmTkhuRGZ6K2hYZmRPemE3ZGpMU2ZWY0hwZjJkRHFqNkgz?=
 =?utf-8?B?RkpLV25WSDFqSVQxenpJK0toZFlUMUYwUk5hc3N5VzVTMUNadU9kSWNvc25N?=
 =?utf-8?B?VEdwRmlhV0RSYXFzSjZWelRlRXBkOEprMU84bGJGV3lNUDFHQUgramsxb1dQ?=
 =?utf-8?B?RDV6U3AwZ0tqcnkrWHBzZ09ZSnBmN1hnY2ZNVWt0U0FRUzA0ajNVNjVjcHRJ?=
 =?utf-8?B?N1BZWE05Yjk3WGR5YmtBZU5hOFpqWXRUOVhHbjFZTWpodmltNmRRajhTUkVQ?=
 =?utf-8?B?M0dmNEJkZ2JlUzFHa3pjQ21aUjJ6MXAwTXExYWI1UWxtcVc1WjdMYm0rc2lx?=
 =?utf-8?B?c3FZY1NRKzRPZm5EQWdwdTlrMHBPalJJUys3bmRYMEZOQVp4cTlQU29RZVpv?=
 =?utf-8?B?b043aDU2VGdCdkxDdUlHbmlFYmNzSnZUQVdUd3lZK3hpek9QdU92bjA0TURQ?=
 =?utf-8?B?THBPV0hjbElBNFU2K0d4OEszS0VNRUJaVGVoQndxQTRrcVMzSUJVQTBWVjVt?=
 =?utf-8?B?Z25zeW1WOHluUm9Tc0pCOS9uWkVjZWdOZDd6WVRZTjYwSytwTjZvWlc4RkVR?=
 =?utf-8?B?SytINHFhcGNkUXRBWFZYRGZDWURSV0RrQVpXSCtaWXZVUjZXT29wTHpXOHNW?=
 =?utf-8?B?ZmViTmRVbGZhcFlEYTB6bjNidk9JSWdMTDRQeHoxWXJvN3BnY1BWSWY5YU5D?=
 =?utf-8?B?UUU3d3h5MkJGdjdqeWsrQkFsUWp1UCtuUkpNMEZ5UW9aUlN6K0xUb295Nm5J?=
 =?utf-8?B?Z0tsZGNEaTZZQWZveHFLRzdtVWxFbE1FaVFMMmF0aGVmeStwanhqcmFrNzlG?=
 =?utf-8?B?bjk1NmtHbnIrK2x0NFNnbzdGcnNXVFRpMjFGUWg3MUpBbUswb01SbUp5SFhr?=
 =?utf-8?B?SGZjVUVwTnA2Rmt2Q1BnQ292a1drck8xbkFycnBLZzRrTGswbnh5VzdORnNx?=
 =?utf-8?B?UTYxanQ4K0RLV0RtOWFJNm1hanNrSzBVZ0JHMVpjTFJMKzlxcXp0SVJ3dHZq?=
 =?utf-8?B?U0JCVkI2cnNGVWs0Tm1NckdDYzZXMFozY0lFY3JVUDN0a0JqK2JVRFQ5SCt4?=
 =?utf-8?B?akRXVkZRczJCeEVuR01lazNPWTB4b3VqMCtBRFA1M3NkZnpZeEQzb0tldFV2?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b6f9f3-586a-4881-77e9-08dbd14e0782
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:22:06.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycQHkeQBu5Mx5C7Zyg9Kh1CJygbF98iUSXqcklGUjTpX58gEUKkVxvYM6HYilH1eRUPas1/5NiFUfjxlGH4jhjxGqpm+QDDEubv1nV7AcRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_022220_961499_BAFFFDAF 
X-CRM114-Status: UNSURE (   6.94  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Q2xhbmcgdXNlcyBhIGRpZmZlcmVudCBzZXQgb2YgQ0xJIGFyZ3MgZm9yIGNvdmVyYWdlLCBhbmQg
dGhlIG91dHB1dApuZWVkcyB0byBiZSBwcm9jZXNzZWQgYnkgYSBkaWZmZXJlbnQgc2V0IG9mIHRv
b2xzLgpVcGRhdGUgdGhlIE1ha2VmaWxlIGFuZCBhZGQgYW4gZXhhbXBsZSBvZiB1c2FnZSBpbiBr
dW5pdCBkb2NzLgoKTWljaGHFgiBXaW5pYXJza2kgKDIpOgogIGFyY2g6IHVtOiBBZGQgQ2xhbmcg
Y292ZXJhZ2Ugc3VwcG9ydAogIERvY3VtZW50YXRpb246IGt1bml0OiBBZGQgY2xhbmcgVU1MIGNv
dmVyYWdlIGV4YW1wbGUKCiBEb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9ydW5uaW5nX3Rp
cHMucnN0IHwgMTEgKysrKysrKysrKysKIGFyY2gvdW0vTWFrZWZpbGUtc2thcyAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspCgotLSAKMi40Mi4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
