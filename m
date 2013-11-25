Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1VkwgF-0004Qs-U5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 13:58:27 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VkwgE-0005E0-4q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 13:58:27 +0000
Received: from mail.polarparty.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id EBA431D1C54
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 25 Nov 2013 14:55:48 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 25 Nov 2013 14:55:48 +0100
From: stian@nixia.no
In-Reply-To: <529217CD.1000204@gmx.de>
References: <529217CD.1000204@gmx.de>
Message-ID: <94b43f437c6e933128a54f87dad91593@nixia.no>
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
Subject: Re: [uml-devel] why does index in truncate_inode_pages_range()
 grows so much ?
To: user-mode-linux-devel@lists.sourceforge.net

RGVuIDIwMTMtMTEtMjQgMTY6MTQsIHNrcmV2IFRvcmFsZiBGw7Zyc3RlcjoKPiBhbmQgZ290ICh3
aGlsZSBmdXp6eWluZyB0aGUgVU1MIGd1ZXN0IHdpdGggdHJpbml0eSkgdGhpcyBvdXRwdXQgaW4g
Cj4gdGhlCj4gVU1MIGd1ZXN0Ogo+Cj4KPiBOb3YgMjQgMTI6MDY6NTMgdHJpbml0eSBrZXJuZWw6
IGluZGV4OjQyIGVuZDo0Mjk0OTY3Mjk1Cj4gSSdtIHdvbmRlcmluZyBpZiBpbmRleCBpcyBleHBl
Y3RlZCB0byBiZWNvbWUgc29tZXRpbWVzIHNvIGJpZy4KCjQyOTQ5NjcyOTUgPSAweGZmZmZmZmZm
Cgpsb29rcyBsaWtlIHNvbWV0aGluZyB1bmRlcmZsb3dlZAoKClN0aWFuIFNramVsc3RhZAoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tClNoYXBlIHRoZSBNb2JpbGUgRXhwZXJpZW5jZTogRnJlZSBTdWJz
Y3JpcHRpb24KU29mdHdhcmUgZXhwZXJ0cyBhbmQgZGV2ZWxvcGVyczogQmUgYXQgdGhlIGZvcmVm
cm9udCBvZiB0ZWNoIGlubm92YXRpb24uCkludGVsKFIpIFNvZnR3YXJlIEFkcmVuYWxpbmUgZGVs
aXZlcnMgc3RyYXRlZ2ljIGluc2lnaHQgYW5kIGdhbWUtY2hhbmdpbmcgCmNvbnZlcnNhdGlvbnMg
dGhhdCBzaGFwZSB0aGUgcmFwaWRseSBldm9sdmluZyBtb2JpbGUgbGFuZHNjYXBlLiBTaWduIHVw
IG5vdy4gCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD02MzQz
MTMxMSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXIt
bW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

