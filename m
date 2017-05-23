Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dDIYV-0000fR-T8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 22:45:31 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dDIYT-00089U-SL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 22:45:31 +0000
Received: from [95.222.25.33] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1dDIYN-0002fj-GG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2017 00:45:23 +0200
Message-ID: <1495579510.11734.2.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Wed, 24 May 2017 00:45:10 +0200
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] um: userspace - be more verbose in ptrace set
	regs error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

V2hlbiBwdHJhY2UgZmFpbHMgdG8gc2V0IEdQL0ZQIHJlZ3MgZm9yIHRoZSB0YXJnZXQgcHJvY2Vz
cywKbG9nIHRoZSBlcnJvciBiZWZvcmUgY3Jhc2hpbmcgdGhlIFVNTCBrZXJuZWwuCgpTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgTWV5ZXIgPHRob21hc0BtM3kzci5kZT4KLS0tCsKgYXJjaC91bS9vcy1M
aW51eC9za2FzL3Byb2Nlc3MuYyB8IDEwICsrKysrKysrLS0KwqAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0vb3MtTGlu
dXgvc2thcy9wcm9jZXNzLmMgYi9hcmNoL3VtL29zLUxpbnV4L3NrYXMvcHJvY2Vzcy5jCmluZGV4
IDQ1MzA4NjcuLjgxOWQ2ODYgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vb3MtTGludXgvc2thcy9wcm9j
ZXNzLmMKKysrIGIvYXJjaC91bS9vcy1MaW51eC9za2FzL3Byb2Nlc3MuYwpAQCAtMzUyLDExICsz
NTIsMTcgQEAgdm9pZCB1c2Vyc3BhY2Uoc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzKQrCoAkJwqAq
IGZhaWwuwqDCoEluIHRoaXMgY2FzZSwgdGhlcmUgaXMgbm90aGluZyB0byBkbyBidXQKwqAJCcKg
KiBqdXN0IGtpbGwgdGhlIHByb2Nlc3MuCsKgCQnCoCovCi0JCWlmIChwdHJhY2UoUFRSQUNFX1NF
VFJFR1MsIHBpZCwgMCwgcmVncy0+Z3ApKQorCQlpZiAocHRyYWNlKFBUUkFDRV9TRVRSRUdTLCBw
aWQsIDAsIHJlZ3MtPmdwKSkgeworCQkJcHJpbnRrKFVNX0tFUk5fRVJSICJ1c2Vyc3BhY2UgLSBw
dHJhY2Ugc2V0IHJlZ3MgIgorCQkJwqDCoMKgwqDCoMKgwqAiZmFpbGVkLCBlcnJubyA9ICVkXG4i
LCBlcnJubyk7CsKgCQkJZmF0YWxfc2lnc2VndigpOworCQl9CsKgCi0JCWlmIChwdXRfZnBfcmVn
aXN0ZXJzKHBpZCwgcmVncy0+ZnApKQorCQlpZiAocHV0X2ZwX3JlZ2lzdGVycyhwaWQsIHJlZ3Mt
PmZwKSkgeworCQkJcHJpbnRrKFVNX0tFUk5fRVJSICJ1c2Vyc3BhY2UgLSBwdHJhY2Ugc2V0IGZw
IHJlZ3MgIgorCQkJwqDCoMKgwqDCoMKgwqAiZmFpbGVkLCBlcnJubyA9ICVkXG4iLCBlcnJubyk7
CsKgCQkJZmF0YWxfc2lnc2VndigpOworCQl9CsKgCsKgCQkvKiBOb3cgd2Ugc2V0IGxvY2FsX3Vz
aW5nX3N5c2VtdSB0byBiZSB1c2VkIGZvciBvbmUgbG9vcCAqLwrCoAkJbG9jYWxfdXNpbmdfc3lz
ZW11ID0gZ2V0X3VzaW5nX3N5c2VtdSgpOwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91
dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdApl
bmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRv
dApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1v
ZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

