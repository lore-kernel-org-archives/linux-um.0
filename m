Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dDdvu-000685-Bo
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2017 21:35:06 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dDdvq-0006Mc-FB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2017 21:35:06 +0000
Received: from [95.222.30.125] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1dDdvk-0002oV-2v
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2017 23:34:56 +0200
Message-ID: <1495661692.11734.5.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Wed, 24 May 2017 23:34:52 +0200
Mime-Version: 1.0
Subject: [uml-devel] [PATCH v2] um: Add mark_rodata_ro support
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
To: user-mode-linux-devel@lists.sourceforge.net

U2lnbmVkLW9mZi1ieTogVGhvbWFzIE1leWVyIDx0aG9tYXNAbTN5M3IuZGU+Ci0tLQrCoGFyY2gv
dW0vS2NvbmZpZy5jb21tb24gfMKgwqAxICsKwqBhcmNoL3VtL2tlcm5lbC9tZW0uY8KgwqDCoHwg
MTMgKysrKysrKysrKysrLQrCoDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0vS2NvbmZpZy5jb21tb24gYi9hcmNoL3Vt
L0tjb25maWcuY29tbW9uCmluZGV4IDg1ZjZkZDIuLjA2MTAwOWIgMTAwNjQ0Ci0tLSBhL2FyY2gv
dW0vS2NvbmZpZy5jb21tb24KKysrIGIvYXJjaC91bS9LY29uZmlnLmNvbW1vbgpAQCAtMiw2ICsy
LDcgQEAgY29uZmlnIFVNTArCoAlib29sCsKgCWRlZmF1bHQgeQrCoAlzZWxlY3QgQVJDSF9IQVNf
S0NPVgorCXNlbGVjdCBBUkNIX0hBU19TVFJJQ1RfS0VSTkVMX1JXWArCoAlzZWxlY3QgSEFWRV9B
UkNIX0FVRElUU1lTQ0FMTArCoAlzZWxlY3QgSEFWRV9BUkNIX1NFQ0NPTVBfRklMVEVSCsKgCXNl
bGVjdCBIQVZFX1VJRDE2CmRpZmYgLS1naXQgYS9hcmNoL3VtL2tlcm5lbC9tZW0uYyBiL2FyY2gv
dW0va2VybmVsL21lbS5jCmluZGV4IGU3NDM3ZWMuLjg3MDVlZmYgMTAwNjQ0Ci0tLSBhL2FyY2gv
dW0va2VybmVsL21lbS5jCisrKyBiL2FyY2gvdW0va2VybmVsL21lbS5jCkBAIC0xMiw2ICsxMiw3
IEBACsKgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KwqAjaW5jbHVkZSA8YXNtL2ZpeG1hcC5oPgrC
oCNpbmNsdWRlIDxhc20vcGFnZS5oPgorI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5oPgrCoCNpbmNs
dWRlIDxhcy1sYXlvdXQuaD4KwqAjaW5jbHVkZSA8aW5pdC5oPgrCoCNpbmNsdWRlIDxrZXJuLmg+
CkBAIC0xNjgsNyArMTY5LDYgQEAgdm9pZCBfX2luaXQgcGFnaW5nX2luaXQodm9pZCkKwqAgKiBU
aGlzIGNhbid0IGRvIGFueXRoaW5nIGJlY2F1c2Ugbm90aGluZyBpbiB0aGUga2VybmVsIGltYWdl
IGNhbiBiZSBmcmVlZArCoCAqIHNpbmNlIGl0J3Mgbm90IGluIGtlcm5lbCBwaHlzaWNhbCBtZW1v
cnkuCsKgICovCi0KwqB2b2lkIGZyZWVfaW5pdG1lbSh2b2lkKQrCoHsKwqB9CkBAIC0yMzgsMyAr
MjM4LDE0IEBAIHZvaWQgKnVtbF9rbWFsbG9jKGludCBzaXplLCBpbnQgZmxhZ3MpCsKgewrCoAly
ZXR1cm4ga21hbGxvYyhzaXplLCBmbGFncyk7CsKgfQorCit2b2lkIG1hcmtfcm9kYXRhX3JvKHZv
aWQpCit7CisJLyogcm9kYXRhX3N0YXJ0L2VuZCBtdXN0IGJlIFBBR0VfU0laRSBhbGlnZW5kISAq
LworCXVuc2lnbmVkIGxvbmcgcm9kYXRhX3N0YXJ0ID0gKHVuc2lnbmVkIGxvbmcpIF9fc3RhcnRf
cm9kYXRhOworCXVuc2lnbmVkIGxvbmcgcm9kYXRhX2VuZCA9ICh1bnNpZ25lZCBsb25nKSBfX2Vu
ZF9yb2RhdGE7CisKKwlwcmludGsoS0VSTl9JTkZPICJXcml0ZSBwcm90ZWN0aW5nIHRoZSBrZXJu
ZWwgcmVhZC1vbmx5IGRhdGE6ICVsdWtcbiIsCisJwqDCoMKgwqDCoMKgwqAocm9kYXRhX2VuZCAt
IHJvZGF0YV9zdGFydCkgPj4gMTApOworCW9zX3Byb3RlY3RfbWVtb3J5KCh2b2lkKilyb2RhdGFf
c3RhcnQsIChyb2RhdGFfZW5kIC0gcm9kYXRhX3N0YXJ0KSwgMSwgMCwgMCk7Cit9CgotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9u
ZSBvZiB0aGUgd29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEg
aHR0cDovL3NkbS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1t
b2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

