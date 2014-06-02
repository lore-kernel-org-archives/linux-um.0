Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1WrOKN-0002o1-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Jun 2014 09:14:47 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WrOKM-0002ar-1D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Jun 2014 09:14:47 +0000
Message-ID: <538C407E.5080203@nod.at>
Date: Mon, 02 Jun 2014 11:14:38 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <CAOV6k-BK_oQQ9MwQ1ggp==QPh-vQ=_Kz7j0rVquqAeuoyjr=4w@mail.gmail.com>
	<CAFLxGvw+0L2SSXGzddOgG56g1avyuU4EvUG_peMowe65fh02pQ@mail.gmail.com>
	<CAOV6k-Br0_aa6+3CDZVcqpOwY+YQR7BE8L2kUTSusp8W-3bBKw@mail.gmail.com>
In-Reply-To: <CAOV6k-Br0_aa6+3CDZVcqpOwY+YQR7BE8L2kUTSusp8W-3bBKw@mail.gmail.com>
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
Subject: Re: [uml-devel] Skas Mode : How does it work ?
To: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>, Richard Weinberger <richard.weinberger@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

SGkhCgpBbSAwMi4wNi4yMDE0IDExOjA1LCBzY2hyaWViIFPDqWJhc3RpZW4gRnLDqW1hbDoKPiBI
ZWxsbywKPiAKPiBUaGFuayB5b3UgZm9yIHRoZXNlIGluZm9ybWF0aW9ucywgaXQgaGVscHMgbWUg
dG8gdW5kZXJzdGFuZCBob3cgc2thcyB3b3Jrcy4gSSByZWFkIG9uIHRoZSBza2FzIHdlYnNpdGUg
dGhhdCAiVGhpcyBhbHNvIHByb3ZpZGVzIGEgbm90aWNhYmxlIHNwZWVkdXAgYnkgZWxpbWluYXRp
bmcgdGhlIHNpZ25hbAo+IGRlbGl2ZXJ5IHRoYXQgdXNlZCB0byBoYXBwZW4gZm9yIGV2ZXJ5IFVN
TCBzeXN0ZW0gY2FsbC4iIEkgcmVhZCB0aGF0IFVNTCBwcm9jZXNzZXMgKGluIFRUIG1vZGUpIGlu
IHVzZXIgc3BhY2Ugd2VyZSBjb250cm9sbGVkIHdpdGggc2lnbmFscyAoZXNwZWNpYWxseSB0byBk
byB0aGUgdHJhbnNpdGlvbiBiZXR3ZWVuCj4gdGhlIHVzZXIgbW9kZSBhbmQgdGhlIGtlcm5lbCBt
b2RlKS4gVGhlIHByZXNlbnRhdGlvbiBvZiBza2FzIHN1Z2dlc3RzIHRoYXQgdGhpcyB0cmFuc2l0
aW9uIGFuZCBjb21tdW5pY2F0aW9ucyBiZXR3ZWVuIFVNTCBhbmQgaXRzIHByb2Nlc3NlcyBhcmUg
bm90IGV4ZWN1dGVkIGFueW1vcmUgd2l0aCBzaWduYWxzLgo+IERvIHlvdSBrbm93IHdoYXQgaXMg
dXNlZCBpbnN0ZWFkID8KCkluIFNBU0swIG1vZGUgVU1MIGNvbnRyb2xzIHRoZSBndWVzdCBwcm9j
ZXNzZXMgdXNpbmcgdGhlIHN0dWIgcGFnZXMuCkV2ZXJ5IGd1ZXN0IHByb2Nlc3MgaGFzIHR3byBp
bnN0YWxsZWQgd2hlcmUgdGhlIFVNTCBrZXJuZWwgY2FuIGluamVjdCBjb21tYW5kcy4KSnVzdCBn
cmVwIHRoZSBzb3VyY2VzIGZvciBTVFVCX0NPREUgYW5kIFNUVUJfREFUQS4KClRoYW5rcywKLy9y
aWNoYXJkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGVhcm4gR3JhcGggRGF0YWJhc2VzIC0gRG93
bmxvYWQgRlJFRSBPJ1JlaWxseSBCb29rCiJHcmFwaCBEYXRhYmFzZXMiIGlzIHRoZSBkZWZpbml0
aXZlIG5ldyBndWlkZSB0byBncmFwaCBkYXRhYmFzZXMgYW5kIHRoZWlyIAphcHBsaWNhdGlvbnMu
IFdyaXR0ZW4gYnkgdGhyZWUgYWNjbGFpbWVkIGxlYWRlcnMgaW4gdGhlIGZpZWxkLCAKdGhpcyBm
aXJzdCBlZGl0aW9uIGlzIG5vdyBhdmFpbGFibGUuIERvd25sb2FkIHlvdXIgZnJlZSBib29rIHRv
ZGF5IQpodHRwOi8vcC5zZi5uZXQvc2Z1L05lb1RlY2gKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlz
dApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

