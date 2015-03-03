Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1YSiGC-0006bI-K0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 08:33:00 +0000
Received: from mail-vc0-f182.google.com ([209.85.220.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YSiGA-0008V6-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 08:33:00 +0000
Received: by mail-vc0-f182.google.com with SMTP id hy4so58511vcb.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 Mar 2015 00:32:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>
References: <CAKD1Yr31WXUM-s71bUw+N13AmuAaT0cEhNGYp+VyOA1biGg16w@mail.gmail.com>
Date: Tue, 3 Mar 2015 09:32:52 +0100
Message-ID: <CAFLxGvzOyRKxQxtCSXePZWiH4SaJKhErKq20Hucx-_=_eXd8aw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] Warning in syscall_trace_enter
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Erik Kline <ek@google.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

T24gVHVlLCBNYXIgMywgMjAxNSBhdCA1OjU1IEFNLCBMb3JlbnpvIENvbGl0dGkgPGxvcmVuem9A
Z29vZ2xlLmNvbT4gd3JvdGU6Cj4gSGksCj4KPiB3aGVuIGNvbXBpbGluZyBVTUwgd2l0aCAtV2Fs
bCAtV2Vycm9yLCBJIGdldDoKCkRvbid0IGJ1aWxkIHdpdGggLVdlcnJvci4KCj4gYXJjaC91bS9r
ZXJuZWwvcHRyYWNlLmM6IEluIGZ1bmN0aW9uIOKAmHN5c2NhbGxfdHJhY2VfZW50ZXLigJk6Cj4g
YXJjaC91bS9rZXJuZWwvcHRyYWNlLmM6MTc4OjMyOiB3YXJuaW5nOiBpZ25vcmluZyByZXR1cm4g
dmFsdWUgb2YKPiDigJh0cmFjZWhvb2tfcmVwb3J0X3N5c2NhbGxfZW50cnnigJksIGRlY2xhcmVk
IHdpdGggYXR0cmlidXRlCj4gd2Fybl91bnVzZWRfcmVzdWx0IFstV3VudXNlZC1yZXN1bHRdCj4g
ZXJyb3IsIGZvcmJpZGRlbiB3YXJuaW5nOiBwdHJhY2UuYzoxNzgKPiBtYWtlWzFdOiAqKiogW2Fy
Y2gvdW0va2VybmVsL3B0cmFjZS5vXSBFcnJvciAxCj4KPiBUaGlzIGNvZGUgaGFzbid0IGNoYW5n
ZWQgaW4gYSBsb25nIHRpbWUgKHNpbmNlIDFiZmEyMzE3IGluIE1heSAyMDEyLCBJCj4gdGhpbmsp
LCBzbyBJIGFzc3VtZSB0aGlzIGlzIGludGVudGlvbmFsPwo+Cj4gQW55IHRob3VnaHRzIG9uIHdo
ZXRoZXIgeW91J2QgbGlrZSB0byBmaXggdGhpcyB1cHN0cmVhbSwgYW5kIGlmIHNvCj4gaG93PyBJ
IGNhbiBwdXQgYSB0cml2aWFsIGZpeCBpbnRvIG91ciB0cmVlcyAoYXNzaWduIHRoZSByZXN1bHQg
dG8gYQo+IGR1bW15IHZhcmlhYmxlLCBvciBkbyAiaWYgKHRyYWNlaG9va19yZXBvcnRfc3lzY2Fs
bF9lbnRyeSgpKSByZXR1cm47IikKPiBidXQgaWYgeW91J3JlIHRoaW5raW5nIG9mIGZpeGluZyBp
dCB1cHN0cmVhbSBJIHNob3VsZCBwcm9iYWJseSB3YWl0IHRvCj4gY2hlcnJ5LXBpY2sgd2hhdGV2
ZXIgZml4IHlvdSBkZWNpZGUgb24uIEp1c3QgcHV0dGluZyAodm9pZCkgaW4gZnJvbnQKPiBvZiB0
aGUgZnVuY3Rpb24gZG9lcyBub3Qgc2lsZW5jZSB0aGUgd2FybmluZyBnY2MuIChUaGlzIGlzIGFw
cGFyZW50bHkKPiB3b3JraW5nIGFzIGludGVuZGVkIC0gc2VlCj4gaHR0cHM6Ly9nY2MuZ251Lm9y
Zy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9MjU1MDkjYzI2ICkKCklJUkMgdGhlIGJpZyBwbGFu
IGlzIHRvIG1ha2UgdHJhY2Vob29rX3JlcG9ydF9zeXNjYWxsX2VudHJ5KCkgdHJlZS13aWRlIHZv
aWQuCgotLSAKVGhhbmtzLAovL3JpY2hhcmQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpEaXZlIGlu
dG8gdGhlIFdvcmxkIG9mIFBhcmFsbGVsIFByb2dyYW1taW5nIFRoZSBHbyBQYXJhbGxlbCBXZWJz
aXRlLCBzcG9uc29yZWQKYnkgSW50ZWwgYW5kIGRldmVsb3BlZCBpbiBwYXJ0bmVyc2hpcCB3aXRo
IFNsYXNoZG90IE1lZGlhLCBpcyB5b3VyIGh1YiBmb3IgYWxsCnRoaW5ncyBwYXJhbGxlbCBzb2Z0
d2FyZSBkZXZlbG9wbWVudCwgZnJvbSB3ZWVrbHkgdGhvdWdodCBsZWFkZXJzaGlwIGJsb2dzIHRv
Cm5ld3MsIHZpZGVvcywgY2FzZSBzdHVkaWVzLCB0dXRvcmlhbHMgYW5kIG1vcmUuIFRha2UgYSBs
b29rIGFuZCBqb2luIHRoZSAKY29udmVyc2F0aW9uIG5vdy4gaHR0cDovL2dvcGFyYWxsZWwuc291
cmNlZm9yZ2UubmV0LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

