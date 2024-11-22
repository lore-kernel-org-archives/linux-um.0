Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3DAE6918E
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wG2inwSpR/9+X54wlCts1dEXVIrIecNMNuwaBfvJ464=; b=cB3pq1SyfACIlj9zoWKlXWw6v6
	kpg2oF+MiAHM87GmnhDJEQfPGD/6AVx0sSffXq94+tUklFNHrvFN2DTbD/cFTKy4djjg2tHkwXryW
	KUKaYCT9pXi+hrJSUR050XUuv6uIGVPToxZ9PC56FHuU2SMPpD5NtHlDgSfh7ZHE7W1g7ZQQQXX6b
	+vnBKCqDn+DN1rZCclafLrhrG4oAwQjc0UaNbQq4jIDA1WpC74hAp/P+YL0ZXsf6GomALmjjaoA4q
	ngWVWEJKBFWDzIDeQrk+zwaPHVMtIeyvyaE5kAtDg275FmWOU1xK9fuwtMQyRXbdtp5JrdC3dBMtA
	pIr0R9Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEZLB-00000003CSE-2lIP;
	Fri, 22 Nov 2024 19:29:17 +0000
Received: from ewa-mbsout-02.mbs.boeing.net ([130.76.20.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEZL8-00000003CR7-1zao
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 19:29:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by ewa-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 4AMJT4fV028071;
	Fri, 22 Nov 2024 11:29:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1732303751;
	bh=wG2inwSpR/9+X54wlCts1dEXVIrIecNMNuwaBfvJ464=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LsEQ7LtcR9sP47E6r5F/EI5LFYYhNnoequTqgwbeSkJLVrC7B6FjXDsgH0/mYXDOI
	 KggVQPvtpjkStulYl7sH1BQc9w2VhG0s7MltQe8XYfnhS0vARYfFWRoDB1LJWLZhS1
	 kvnGJpavpvqfy7AvfbM1MPbt7eYB6TDSiVcQBWGeTwVbsF93mBu4465x/hetKp84Ba
	 yzNidQpbEv4hWNxH1yLLvIAjU8W+CUS7VAsHSBAIHZ8rUf17+s88Ix3fIFkdILU+jy
	 nAnmz4jh35Nf5DHNEA5TcHDXuj6XafQi99HEUHY84LQfuRcuqdPSzXg65pDuGIvi0P
	 4C0ipOsm9/jtQ==
Received: from XCH16-03-02.nos.boeing.com (xch16-03-02.nos.boeing.com [137.137.111.11])
	by ewa-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 4AMJSmxp027883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Nov 2024 11:28:49 -0800
Received: from XCH16-03-04.nos.boeing.com (137.137.111.13) by
 XCH16-03-02.nos.boeing.com (137.137.111.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 11:28:46 -0800
Received: from XCH16-03-04.nos.boeing.com ([fe80::7809:c78b:36c8:935e]) by
 XCH16-03-04.nos.boeing.com ([fe80::7809:c78b:36c8:935e%13]) with mapi id
 15.01.2507.039; Fri, 22 Nov 2024 11:28:46 -0800
From: "Wolber (US), Chuck" <chuck.wolber@boeing.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor
	<nathan@kernel.org>
CC: Wentao Zhang <wentaoz5@illinois.edu>,
        "Kelly (US), Matt"
	<Matt.Kelly2@boeing.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "Oppelt (US), Andrew J"
	<andrew.j.oppelt@boeing.com>,
        "anton.ivanov@cambridgegreys.com"
	<anton.ivanov@cambridgegreys.com>,
        "ardb@kernel.org" <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jinghao7@illinois.edu"
	<jinghao7@illinois.edu>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "justinstitt@google.com" <justinstitt@google.com>,
        "kees@kernel.org"
	<kees@kernel.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "luto@kernel.org"
	<luto@kernel.org>,
        "marinov@illinois.edu" <marinov@illinois.edu>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "maskray@google.com"
	<maskray@google.com>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "Weber (US), Matthew L"
	<matthew.l.weber3@boeing.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "morbo@google.com" <morbo@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "oberpar@linux.ibm.com"
	<oberpar@linux.ibm.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "Sarkisian (US), Samuel" <samuel.sarkisian@boeing.com>,
        "Vanderleest (US),
 Steven H" <steven.h.vanderleest@boeing.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "tingxur@illinois.edu" <tingxur@illinois.edu>,
        "tyxu@illinois.edu" <tyxu@illinois.edu>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's
 Source-based Code Coverage and MC/DC with Clang
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's
 Source-based Code Coverage and MC/DC with Clang
Thread-Index: AQHbFIcZxf21kGRuK0Wyyav9pF/OKLJzeOYAgAKrngCATew1gP//77aA
Date: Fri, 22 Nov 2024 19:28:46 +0000
Message-ID: <5F5EA6BE-94BD-4352-ADA9-D14BBE703D4F@boeing.com>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <20241122122703.GW24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122122703.GW24774@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.90.24110120
x-originating-ip: [137.137.12.6]
x-tm-snts-smtp: 7DF70432748D194DD0E592FE746D6476C899CCB5789BECADCB3900194B2B36932000:8
Content-Type: text/plain; charset="utf-8"
Content-ID: <16FA026E611EC84494309EE6F018901D@boeing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_112914_602370_3E5B86FC 
X-CRM114-Status: GOOD (  10.67  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

PiA+IE9uIFRodSwgT2N0IDAzLCAyMDI0IGF0IDA0OjI5OjM4UE0gLTA3MDAsIE5hdGhhbiBDaGFu
Y2VsbG9yIHdyb3RlOg0KPiA+DQo+ID4gJCAvdXNyL2Jpbi90aW1lIC12IG1ha2UgLXNraiIkKG5w
cm9jKSIgQVJDSD14ODZfNjQgTExWTT0xIG1ycHJvcGVyIHtkZWYsYW1kX21lbV9lbmNyeXB0Lixm
b3J0aWZ5X3NvdXJjZS4sbGx2bV9jb3YufWNvbmZpZyBiekltYWdlDQo+ID4gLi4uDQo+ID4gdm1s
aW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBfX3Nldl9lc19ubWlfY29tcGxldGUrMHg2ZTogY2Fs
bCB0byBrYXNhbl9jaGVja193cml0ZSgpIGxlYXZlcyAubm9pbnN0ci50ZXh0IHNlY3Rpb24NCg0K
JTwgU05JUCAlPA0KDQo+ID4gdm1saW51eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBhY3BpX2lkbGVf
ZG9fZW50cnkrMHg0OiBjYWxsIHRvIHBlcmZfbG9wd3JfY2IoKSBsZWF2ZXMgLm5vaW5zdHIudGV4
dCBzZWN0aW9uDQo+DQo+DQo+IEp1c3Qgc2F3IHRoaXMgZmx5IGJ5LCB0aGF0IGxvb2tzIGxpa2Ug
c29tZXRoaW5nIGlzIGJ1Z2dlcmVkIGJhZC4gTm90YWJseQ0KPiBsb2NrZGVwX2hhcmRpcnFzX3tv
bixvZmZ9KCkgYXJlIG5vaW5zdHIuDQo+DQo+DQo+IElzIHRoaXMgcGF0Y2gtc2V0IGNhdXNpbmcg
dGhpcywgb3Igd2hhdD8NCg0KTm8sIHRoZXNlIHBhdGNoZXMgYXJlIG5vdCBjYXVzaW5nIHRoaXMu
IFRoaXMgcGF0Y2gtc2V0IGFwcGVhcnMgdG8gaGF2ZSBleHBvc2VkIGENCmJ1ZyBpbiB0aGUgbGx2
bSBsaW5rZXIgKGxsZCk6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9p
c3N1ZXMvMTE2NTc1DQoNCi4uQ2g6Vy4uDQoNCg==

