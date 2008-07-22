Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLLtZ-00019s-EE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 10:43:29 -0700
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KLLtX-0003zP-O8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 10:43:29 -0700
Received: by nf-out-0910.google.com with SMTP id g16so605348nfd.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Jul 2008 10:43:26 -0700 (PDT)
Date: Tue, 22 Jul 2008 18:41:52 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080722174152.GF3081@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] uml: fix another build error
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

CkZpeGVkIHRoaXMgZXJyb3I6CgogIENDICAgICAgYXJjaC91bS9kcml2ZXJzL3ZkZV91c2VyLm8K
ICAvaG9tZS93YW5nY29uZy9Qcm9qZWN0cy9saW51eC0yLjYvYXJjaC91bS9kcml2ZXJzL3ZkZV91
c2VyLmM6IEluCmZ1bmN0aW9uIOKAmHZkZV9pbml0X2xpYnN0dWZm4oCZOgovaG9tZS93YW5nY29u
Zy9Qcm9qZWN0cy9saW51eC0yLjYvYXJjaC91bS9kcml2ZXJzL3ZkZV91c2VyLmM6ODE6CmVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhrbWFsbG9j4oCZCi9ob21lL3dh
bmdjb25nL1Byb2plY3RzL2xpbnV4LTIuNi9hcmNoL3VtL2RyaXZlcnMvdmRlX3VzZXIuYzo4MToK
d2FybmluZzogYXNzaWdubWVudCBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEg
Y2FzdAptYWtlWzJdOiAqKiogW2FyY2gvdW0vZHJpdmVycy92ZGVfdXNlci5vXSBFcnJvciAxCm1h
a2VbMV06ICoqKiBbYXJjaC91bS9kcml2ZXJzL3ZkZV91c2VyLmtvXSBFcnJvciAyCm1ha2U6ICoq
KiBbc3ViLW1ha2VdIEVycm9yIDIKClNpZ25lZC1vZmYtYnk6IFdBTkcgQ29uZyA8d2FuZ2NvbmdA
emV1dXgub3JnPgpDYzogamRpa2VAYWRkdG9pdC5jb20KCi0tLQpkaWZmIC0tZ2l0IGEvYXJjaC91
bS9kcml2ZXJzL3ZkZV91c2VyLmMgYi9hcmNoL3VtL2RyaXZlcnMvdmRlX3VzZXIuYwppbmRleCA1
NjUzM2RiLi43NDRlYWNmIDEwMDY0NAotLS0gYS9hcmNoL3VtL2RyaXZlcnMvdmRlX3VzZXIuYwor
KysgYi9hcmNoL3VtL2RyaXZlcnMvdmRlX3VzZXIuYwpAQCAtNzgsNyArNzgsNyBAQCB2b2lkIHZk
ZV9pbml0X2xpYnN0dWZmKHN0cnVjdCB2ZGVfZGF0YSAqdnByaSwgc3RydWN0IHZkZV9pbml0ICpp
bml0KQogewogCXN0cnVjdCB2ZGVfb3Blbl9hcmdzICphcmdzOwogCi0JdnByaS0+YXJncyA9IGtt
YWxsb2Moc2l6ZW9mKHN0cnVjdCB2ZGVfb3Blbl9hcmdzKSwgVU1fR0ZQX0tFUk5FTCk7CisJdnBy
aS0+YXJncyA9IHVtbF9rbWFsbG9jKHNpemVvZihzdHJ1Y3QgdmRlX29wZW5fYXJncyksIFVNX0dG
UF9LRVJORUwpOwogCWlmICh2cHJpLT5hcmdzID09IE5VTEwpIHsKIAkJcHJpbnRrKFVNX0tFUk5f
RVJSICJ2ZGVfaW5pdF9saWJzdHVmZiAtIHZkZV9vcGVuX2FyZ3MgIgogCQkgICAgICAgImFsbG9j
YXRpb24gZmFpbGVkIik7CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNw
b25zb3JlZCBieSB0aGUgTW9ibGluIFlvdXIgTW92ZSBEZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVp
bGQgdGhlIGNvb2xlc3QgTGludXggYmFzZWQgYXBwbGljYXRpb25zIHdpdGggTW9ibGluIFNESyAm
IHdpbiBncmVhdCBwcml6ZXMKR3JhbmQgcHJpemUgaXMgYSB0cmlwIGZvciB0d28gdG8gYW4gT3Bl
biBTb3VyY2UgZXZlbnQgYW55d2hlcmUgaW4gdGhlIHdvcmxkCmh0dHA6Ly9tb2JsaW4tY29udGVz
dC5vcmcvcmVkaXJlY3QucGhwP2Jhbm5lcl9pZD0xMDAmdXJsPS8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxp
bmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1k
ZXZlbAo=
