Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6F7CDB474
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CrosM9rDQR5gbOUHaK7uJz7JdaESi8EBtADXL6tMeeA=; b=tlmwz8o3+02x5R
	vNgHUz/Asiwhk4q5z8HhfTBqnK1v0pkCYVzwB2QS+/yI4gkNmglubNZN4V5YWaIGpOwaTul9bRarX
	vTcf6dVbMyRBYmMyw3WEY+OwwNCu8SnBefbFW/uOBMxYd77hnzG6AP8XXj1+fGgg2vkGoeHatRN8e
	6gJa6J0RN8wET64t/2Klgo8qQQfzMuJzWtN6koIQfYlpeL7VoLBYdCFJTvYPqC5qabdVuLwEVYsQa
	F/Oki76koXlK1bEr+RdmR3KDt50XGcowH9+v55FBMgN9oGtUVj56mt+1EHvAvnqkYo/FAK6U+l43o
	HXNynBpDVHq7ojaEpUOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtli3-001fck-2W;
	Fri, 20 Oct 2023 09:22:23 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtli1-001fbD-0J
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 09:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793741; x=1729329741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gMmsR6/ENqtT3Uvb9ko3vE65+B2JJ9QgLROGyaGVV0A=;
  b=dFD7UYNm6Ud8/EYmJQ+kdE8CO5JOjr3F+0ewJlQSZe149fFu0ihNRSgN
   9nFdmTmzx+tpSmR9Sq8MMgzkn9JdzHjauM0J05N0Kte86bBa32riKLAwA
   SqzsaaG8PpiqLlqqCISSZpZE2PwJwtGCUFtLdqEhkcU6dySQIkbYESCSb
   AQw0HDA3lO65fnP7HNP5vBq/AVvXNZJ8bB/40faU08rDyUvKwRXvdqWqk
   NvNBkT2C/WRuuFY4jYFIdT/pk5/nlyT/MFUaBpRvytNi5m6nyoGFAuvmc
   uKzPYnBlDVn/C6MIrhy/wTl7ApNZ40buOOc7FBqglqGbVdGx3Mcv/HKwZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390347427"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="390347427"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="823180631"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="823180631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 02:22:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 02:22:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 02:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRn9DfgpSJsRuTKB0AuONhdICCzl3XD0JQsr1/yYnjk0hTaMwHTNnPzvp5oGSBsuwnchicRtA1Giy1Y8c7XLenW2EKvXRWOo95bNZ8CN/ci7MIXjdzBgDtsbjOoRvPpgtJXDTXVv53FflCXWiI4I/xNvflBcbzlP5U0ZDU5GCijgI77TnQbPzyBmLWGBfOemMD0W05AvRzqJE2ly8V/rDXZJqoVRrdmgBaaoXYymIm33XSbfIEHS/3cLGaT0Y4s+y4kD9CK8Df9OsibFfREItUUOeXcuN+nCSZQq4WFPZHc9dsOI05kgoOpLg4zxG9ow8U3UryxnlwORqKndUwDGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4Avd15+BPlGH49zWpb2CGvOa5Ab1hUPzNBPlqAUlag=;
 b=Yy7SoNVZF6XlhHhO4PfSLqNSRkpGkjHXP/CZUxF6JwSZbrKbMs4CYE9K3cUOrhB8OBQvUQBfMJFaYHkHVl8VthDVYL97a2GXidpO2Ll259ot6tTwyqGoK3jH7ezZailNIy/briNoXroYripOGHYZpxgyBq5cEp1LKnZC8Fq4AX/7i3arAIlv81m1LYhSrD3KqBvSbMHahTcoS75WeGcPGjR9rPYvXRCxsvc6I7yzpwwdPlIN0+yWSk3UagoMRASubvCEVW47E2d0AVdm+7V5EfiWRLdcIINv7dr5BAKc4xy/aIfw9xbjqYruC2sNLaazKdmoTVLslSFh1de90aZOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 09:22:11 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::cc5d:d2c9:b39a:3de7]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::cc5d:d2c9:b39a:3de7%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 09:22:11 +0000
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
Subject: [PATCH 1/2] arch: um: Add Clang coverage support
Date: Fri, 20 Oct 2023 11:21:58 +0200
Message-ID: <20231020092159.2486063-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020092159.2486063-1-michal.winiarski@intel.com>
References: <20231020092159.2486063-1-michal.winiarski@intel.com>
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|PH8PR11MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: da00d876-bd90-499e-33e0-08dbd14e0a63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5eBQJ9+Ow/AbgV1igtYwYU9QHKkgZskxOr7OsHMYZLr8dXVPOkzRL7WgEmhE334hkALaGqZ/c5C/JPoBlqSHDTPjVQ9sPYlpcWNiDRlWIvAe3OgVaUOuSXuXwuWV1SoJEraFUezBztnpCxMEAmX9ZybHE6sxbN2Xf0XNHXprU18+bsYM4IIxRsZs4dRraUX6YsuAAlEr9d78N3UAS28QknWN/IACIe6zbLZ82eFHl+gUIlj/J5OtJyTkl0jf77zKAZ1BDKwsWmUmx56D37rGmW1aTJn+vPcAO7WfaxLxR/k1wX/KZlB0E+u84HDSrjWbym3/m10huJd4230RAPF/l2bzR6DWIaE2O88LinzXNd1pIAEML3kADGci6c8Wg0CiFtYUQjG9CGYk/YxEVfDrql5f9cc3IL0qoW6xEFhMByZwKOILd/mBDF3uz0bP3/I8z7aJF4Q2IkewY+DjfZcmw16sBAPt1mQC7Qj5rH0gvSxr/mslm0B6TpVVPPY50EoVi4w8Lw1vca6KA/YZk/WXrClcY+rdZLtemz5hIj9YluI6/OTGni3kKFrwrW+p46l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(82960400001)(36756003)(86362001)(4744005)(7416002)(26005)(478600001)(6506007)(6486002)(316002)(2616005)(1076003)(6512007)(8676002)(4326008)(107886003)(8936002)(41300700001)(6666004)(54906003)(66946007)(66556008)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBxR24xb3B5RXhyeWNWdGNOeTlxWWJZa256c2d1K212S1JjRENyanNDb3l4?=
 =?utf-8?B?MU9iOXZlRDJ4UDZna2lmaXNqdDEwc3pLU0Q5WVAwV2oyaVp0U3ZTUzBIbnlk?=
 =?utf-8?B?bW8xWk5RWk9sejhqZ3RjV1oybWhScjVmTEJzcGMwLytiUWZRWkx3TWQ0NU84?=
 =?utf-8?B?bXNPaDFCTmRZM3pxSGhlbWFCWDNsQ0hvUUt5cXVXWlBUN2pOWWZUdTRvaWE1?=
 =?utf-8?B?ZEY3S3NwNDFPK3c0NkhZTmtWK05FM0lFZmtTNXNpWFdTZUF6Z3g1YWhLSllj?=
 =?utf-8?B?ZFZJR3MydnNsWnUvaElYeDgyV1JNelpOL3NlaTlDeEJNakNnNC9MclpEaGxw?=
 =?utf-8?B?RzU1Nk9pV0FONGJkUk10NE1wbmkxQkc2RklOZE5vNm9yeEdyQUVIZGhHY2hR?=
 =?utf-8?B?WVRXbkhKNHoxM3l2Ym81TlpQdHBiWHhzamFMbkpiSEMxa1JGM2ZGS3krRktU?=
 =?utf-8?B?UlFzVmU2Y1N3cFNZaHd3UWFSYkFFZnoxcTdlVlloajR5ODM5RVVRS3VQaHdY?=
 =?utf-8?B?OHIrdDI4TTV5cGhjdTYyNDBrVzUxS2tZNXdVTFBCZEwvRHdtSXdIWXV6ZS9o?=
 =?utf-8?B?WlY1NmVISk1MbjM2aEFrc040cE1HeS9HdUFkS0FadXozZ0h0M0hORWN2Unls?=
 =?utf-8?B?NVRvNCtpdUVjV0tQT1AyZDB6Z0hleTQ0MTEycFNvNHc0VkxEbC9mRDVqcE0y?=
 =?utf-8?B?Tk5Dbyt1SUExbWVTQk1ORGNSNExjY0prcHpkQko0dVkvTXlMK0lyQnAvbysx?=
 =?utf-8?B?U091eSt6S2VHVCs3Ry9Ha1FaTDYwMGUycUlqQ0RRQXA4SzloUGdZeDBReXJY?=
 =?utf-8?B?UytIV2Z0dTJHbEJmb3pjbFcrOXJtNmh1SWZxQi9LZUVxWkwwd1FQVHh6SUll?=
 =?utf-8?B?anZaWmJpbjNtNENyaEtVYk9nQTdOU3lQQ1AvcjdQYVdScDRYbWJwc1REU1FT?=
 =?utf-8?B?RnUyK2daTnNEeEdydm12QVdnU09wLzFXRWFWejM1NXFjK1FGSEVwb1hEOW1q?=
 =?utf-8?B?dGJ4RlFjOXZWNnZFbTZzRStSd1gxeVpCR29uaUN4ZjMrbzNZU2tkNjVBU2J3?=
 =?utf-8?B?SkI3OHh5OFZ1ZC90NFI1cnN1ZlNVVzg5azc5U0xyVlpzTzBIaFFacFVRazg1?=
 =?utf-8?B?dWYzTlhaazRSdnF3cDZZUHMrTzZ0UXRxREpFODF0TzZ4ckNzNzd1QTlnVG40?=
 =?utf-8?B?R1EzdjdzRjZXeHI1OEVqditPZ1FzOC9IZjdiSmJTQ2NwanBkSXRMeUcrc2VN?=
 =?utf-8?B?bmhuOVF2NVJDSEVYU2RlbU04YUpsMFRGL0I5RllwZmFybzF4d2NFb3FtTHlM?=
 =?utf-8?B?QlVGVmxrUDFLSEdQazJ1N0w3SDBSQnI5SEpuVXJVY3dsTVZZeHJQcjFxRHph?=
 =?utf-8?B?aUpzSG42SkljWm83aktOY0JGK0psYkV6bUh3UjJud2R0S0U1OU5kRWtpOUE0?=
 =?utf-8?B?VjNIbUszTG9wZTlYVkV3dzNJV1QwSnhlL1FNeFdOMi95R2E1OWhTR2IrMkJ0?=
 =?utf-8?B?MURMdFB1MkJFbENqYTZrTVU3VFpmQ1QyNlM2eHI0dlZvODlnbnZwLzBlaCtW?=
 =?utf-8?B?VVVtd0FBcDVNOTU0QXYySnZwKzNaaGhWbkdMaXZHMWwybmdHZ250UFJSc3V3?=
 =?utf-8?B?a2wzcjNjVThOeXJlUWR2QVphK0g3UVFyZnRvRHN6QkFka0lJckIwdHpVOVU3?=
 =?utf-8?B?bitMTk5lZDNMYms5Tlc4MGFzZ1RxQ0RTSXJlcy9BM043OUZaVVJhdUhCQUhl?=
 =?utf-8?B?bGlmZzczb1dmVmErazI4TTJIOSszdU5YZTBBNndpYkhGalU2TGdQRHFLaktZ?=
 =?utf-8?B?K1lUaFAwdUNJWkh1bkdHUXlvUTVrTldwT2Z4eUwydmZTTlZja0ZRQlNITCtp?=
 =?utf-8?B?c3lIc0FKK3lSQTd0TjNBcW91ZDl0QXMyS05oaGM3Ni9mcjc1RlpOTVlraWJ0?=
 =?utf-8?B?dUFGanQvUXc0TGRyYkR3N3dsYXRVWUt2aTZZSHkybDRYYzVXZ0FIMWZxQ0Zq?=
 =?utf-8?B?YVlTNXk1SXEvY3lQSVRrakxCZGc5d3lGc1pVSTY0c0p0M202dWF0Z0hLQWFP?=
 =?utf-8?B?c0MxRWs5czJaRHdOaFFWN3RLT2RyMGpNd04va2Z0YTE0dFJXaFM4VGhubit4?=
 =?utf-8?B?V1pTRHAzTDl0VURlT3FjajY3NnlJaFpHTG9sVEJhZFV1U0R3YVN3K3pCVjlh?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da00d876-bd90-499e-33e0-08dbd14e0a63
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:22:11.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVn5He83dNFOu/VJR6CJjv705GiBe0ttpLa10jWdvZCM/lM5GDUxLSHRomRHq8G0D6hTvfikfm6b+jbTl37AKeyj13Xe8S7Ugjl6a3suS6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_022221_185956_047F08F4 
X-CRM114-Status: UNSURE (   8.87  )
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

Q2xhbmcgdXNlcyBhIGRpZmZlcmVudCBzZXQgb2YgY29tbWFuZCBsaW5lIGFyZ3VtZW50cyBmb3Ig
ZW5hYmxpbmcKY292ZXJhZ2UuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIFdpbmlhcnNraSA8bWlj
aGFsLndpbmlhcnNraUBpbnRlbC5jb20+Ci0tLQogYXJjaC91bS9NYWtlZmlsZS1za2FzIHwgNSAr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gv
dW0vTWFrZWZpbGUtc2thcyBiL2FyY2gvdW0vTWFrZWZpbGUtc2thcwppbmRleCBhYzM1ZGU1MzE2
YTYuLjY3MzIzYjAyODk5OSAxMDA2NDQKLS0tIGEvYXJjaC91bS9NYWtlZmlsZS1za2FzCisrKyBi
L2FyY2gvdW0vTWFrZWZpbGUtc2thcwpAQCAtNCw3ICs0LDEyIEBACiAjCiAKIEdQUk9GX09QVCAr
PSAtcGcKKworaWZkZWYgQ09ORklHX0NDX0lTX0NMQU5HCitHQ09WX09QVCArPSAtZnByb2ZpbGUt
aW5zdHItZ2VuZXJhdGUgLWZjb3ZlcmFnZS1tYXBwaW5nCitlbHNlCiBHQ09WX09QVCArPSAtZnBy
b2ZpbGUtYXJjcyAtZnRlc3QtY292ZXJhZ2UKK2VuZGlmCiAKIENGTEFHUy0kKENPTkZJR19HQ09W
KSArPSAkKEdDT1ZfT1BUKQogQ0ZMQUdTLSQoQ09ORklHX0dQUk9GKSArPSAkKEdQUk9GX09QVCkK
LS0gCjIuNDIuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
