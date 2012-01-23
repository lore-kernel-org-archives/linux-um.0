Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1RpTNv-00072U-Pk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Jan 2012 23:33:11 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RpTNv-0007Nb-1g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Jan 2012 23:33:11 +0000
Received: by obbuo9 with SMTP id uo9so5158455obb.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 23 Jan 2012 15:33:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADW8t6xtpMEYrVFvMkT7HMJMeiQoOGzT8LHYG48YMApe3efgJA@mail.gmail.com>
References: <CADW8t6xtpMEYrVFvMkT7HMJMeiQoOGzT8LHYG48YMApe3efgJA@mail.gmail.com>
Date: Tue, 24 Jan 2012 00:33:05 +0100
Message-ID: <CAFLxGvww1okUVX5ccotPUBXjEoN4fjq7Yo0JuHqJg7j3ut82rA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] BUGFIX : insmod fail with message "overflow in
 relocation type 11..." for mem=504M and above
To: =?UTF-8?B?7KCE7ZWY64qY?= <allskyee@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

SGkhCgpPbiBXZWQsIEphbiAxOCwgMjAxMiBhdCAzOjMxIFBNLCDsoITtlZjripggPGFsbHNreWVl
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gSSBmb3VuZCB0aGUgcHJvYmxlbSB3aGlsZSB0cmFuc2l0aW9u
aW5nIHRvIGEgNjRiaXQgbWFjaGluZQo+Cj4gVGhlIHByb2JsZW0gc2VlbXMgdG8gZXhpc3QgZm9y
IHBoeXNpY2FsIG1lbW9yeSBleGNlZWRpbmcgNTA0TUIgYmVjYXVzZcKgdGhhdAo+IGlzIHRoZSBw
cmVjaXNlIGxpbWl0IHdoaWNoIHRpcHMgVk1BTExPQ19TVEFSVCB3aXRoIE1TQiBiZWluZyAxCj4K
PiBUaGF0IHdvdWxkIGJlIGEgcHJvYmxlbSBmb3IgNjRiaXQgbWFjaGluZXMgc2luY2UgaW7CoHN5
bWJvbCByZWxvY2F0aW9uCj4gZnVuY3Rpb24sIG5hbWVseSBhcHBseV9yZWxvY2F0ZV9hZGQgaW7C
oGFyY2gveDg2L2tlcm5lbC9tb2R1bGUuYzoyNDksCj4gZXZhbHVhdGluZyBSX1g4Nl82NF8zMlPC
oHNpZ24gZXh0ZW5kcyA2NGJpdCB2YWx1ZXMKPgo+IFRoZSByb290IG9mIHRoZSBwcm9ibGVtIHRo
b3VnaCwgaXMgdGhhdMKgIFZNQUxMT0NfU1RBUlTCoMKgc3RhcnQgaXMgdG9vIGJpZyB0bwo+IGJl
Z2luIHdpdGggc2luY2UgU1RBUlQgaXMgdG9vIGJpZyBpbsKgTWFrZWZpbGUteDg2XzY0Cj4KPiBD
aGFuZ2luZyB0byBhIHNtYWxsZXIgdmFsdWUsIGxpa2Ugc2F5wqAweDgwNDgwMDAgdXNlZCBmb3Ig
aTM4NiBtYWNoaW5lcyBzZWVtcwo+IHRvIGRvIHRoZSB0cmljawo+Cj4gQW55IHJlYXNvbiBpdCB3
YXPCoDB4NjAwMDAwMDAgPz8KClRoYW5rcyBmb3IgdGhlIGJ1ZyByZXBvcnQuClZNQUxMT0NfU1RB
UlQgaXNuJ3QgaGFyZGNvZGVkLCB3aGljaCBrZXJuZWwgYXJlIHlvdSB1c2luZz8KCi0tIApUaGFu
a3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRyeSBiZWZvcmUgeW91IGJ1eSA9
IFNlZSBvdXIgZXhwZXJ0cyBpbiBhY3Rpb24hClRoZSBtb3N0IGNvbXByZWhlbnNpdmUgb25saW5l
IGxlYXJuaW5nIGxpYnJhcnkgZm9yIE1pY3Jvc29mdCBkZXZlbG9wZXJzCmlzIGp1c3QgJDk5Ljk5
ISBWaXN1YWwgU3R1ZGlvLCBTaGFyZVBvaW50LCBTUUwgLSBwbHVzIEhUTUw1LCBDU1MzLCBNVkMz
LApNZXRybyBTdHlsZSBBcHBzLCBtb3JlLiBGcmVlIGZ1dHVyZSByZWxlYXNlcyB3aGVuIHlvdSBz
dWJzY3JpYmUgbm93IQpodHRwOi8vcC5zZi5uZXQvc2Z1L2xlYXJuZGV2bm93LWRldjIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4
LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXIt
bW9kZS1saW51eC1kZXZlbAo=

