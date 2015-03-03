Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lorenzo@google.com>) id 1YSerx-00040P-Df
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 04:55:45 +0000
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YSerw-0008K6-CR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 04:55:45 +0000
Received: by iery20 with SMTP id y20so813631ier.12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Mar 2015 20:55:39 -0800 (PST)
MIME-Version: 1.0
From: Lorenzo Colitti <lorenzo@google.com>
Date: Tue, 3 Mar 2015 13:55:18 +0900
Message-ID: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>
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
Subject: [uml-devel] Warning in syscall_trace_enter
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Erik Kline <ek@google.com>

SGksCgp3aGVuIGNvbXBpbGluZyBVTUwgd2l0aCAtV2FsbCAtV2Vycm9yLCBJIGdldDoKCmFyY2gv
dW0va2VybmVsL3B0cmFjZS5jOiBJbiBmdW5jdGlvbiDigJhzeXNjYWxsX3RyYWNlX2VudGVy4oCZ
OgphcmNoL3VtL2tlcm5lbC9wdHJhY2UuYzoxNzg6MzI6IHdhcm5pbmc6IGlnbm9yaW5nIHJldHVy
biB2YWx1ZSBvZgrigJh0cmFjZWhvb2tfcmVwb3J0X3N5c2NhbGxfZW50cnnigJksIGRlY2xhcmVk
IHdpdGggYXR0cmlidXRlCndhcm5fdW51c2VkX3Jlc3VsdCBbLVd1bnVzZWQtcmVzdWx0XQplcnJv
ciwgZm9yYmlkZGVuIHdhcm5pbmc6IHB0cmFjZS5jOjE3OAptYWtlWzFdOiAqKiogW2FyY2gvdW0v
a2VybmVsL3B0cmFjZS5vXSBFcnJvciAxCgpUaGlzIGNvZGUgaGFzbid0IGNoYW5nZWQgaW4gYSBs
b25nIHRpbWUgKHNpbmNlIDFiZmEyMzE3IGluIE1heSAyMDEyLCBJCnRoaW5rKSwgc28gSSBhc3N1
bWUgdGhpcyBpcyBpbnRlbnRpb25hbD8KCkFueSB0aG91Z2h0cyBvbiB3aGV0aGVyIHlvdSdkIGxp
a2UgdG8gZml4IHRoaXMgdXBzdHJlYW0sIGFuZCBpZiBzbwpob3c/IEkgY2FuIHB1dCBhIHRyaXZp
YWwgZml4IGludG8gb3VyIHRyZWVzIChhc3NpZ24gdGhlIHJlc3VsdCB0byBhCmR1bW15IHZhcmlh
YmxlLCBvciBkbyAiaWYgKHRyYWNlaG9va19yZXBvcnRfc3lzY2FsbF9lbnRyeSgpKSByZXR1cm47
IikKYnV0IGlmIHlvdSdyZSB0aGlua2luZyBvZiBmaXhpbmcgaXQgdXBzdHJlYW0gSSBzaG91bGQg
cHJvYmFibHkgd2FpdCB0bwpjaGVycnktcGljayB3aGF0ZXZlciBmaXggeW91IGRlY2lkZSBvbi4g
SnVzdCBwdXR0aW5nICh2b2lkKSBpbiBmcm9udApvZiB0aGUgZnVuY3Rpb24gZG9lcyBub3Qgc2ls
ZW5jZSB0aGUgd2FybmluZyBnY2MuIChUaGlzIGlzIGFwcGFyZW50bHkKd29ya2luZyBhcyBpbnRl
bmRlZCAtIHNlZQpodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD0y
NTUwOSNjMjYgKQoKVGhhbmtzLApMb3JlbnpvCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRGl2ZSBp
bnRvIHRoZSBXb3JsZCBvZiBQYXJhbGxlbCBQcm9ncmFtbWluZyBUaGUgR28gUGFyYWxsZWwgV2Vi
c2l0ZSwgc3BvbnNvcmVkCmJ5IEludGVsIGFuZCBkZXZlbG9wZWQgaW4gcGFydG5lcnNoaXAgd2l0
aCBTbGFzaGRvdCBNZWRpYSwgaXMgeW91ciBodWIgZm9yIGFsbAp0aGluZ3MgcGFyYWxsZWwgc29m
dHdhcmUgZGV2ZWxvcG1lbnQsIGZyb20gd2Vla2x5IHRob3VnaHQgbGVhZGVyc2hpcCBibG9ncyB0
bwpuZXdzLCB2aWRlb3MsIGNhc2Ugc3R1ZGllcywgdHV0b3JpYWxzIGFuZCBtb3JlLiBUYWtlIGEg
bG9vayBhbmQgam9pbiB0aGUgCmNvbnZlcnNhdGlvbiBub3cuIGh0dHA6Ly9nb3BhcmFsbGVsLnNv
dXJjZWZvcmdlLm5ldC8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

