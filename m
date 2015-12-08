Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1a6Q5D-0005E4-8s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:46:03 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1a6Q5C-0007MP-BJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:46:03 +0000
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
	<1448805802-12156-2-git-send-email-mic@digikod.net>
	<CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
	<56641CEA.5080202@digikod.net> <566449A3.6030504@digikod.net>
	<CADNZ+wTtu5gZuztSAnY9TE0fV4cVgqr534gyDUEkp0LS=Vq4Xw@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56674F91.8050108@nod.at>
Date: Tue, 8 Dec 2015 22:45:53 +0100
MIME-Version: 1.0
In-Reply-To: <CADNZ+wTtu5gZuztSAnY9TE0fV4cVgqr534gyDUEkp0LS=Vq4Xw@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2 1/2] um: Set secure access mode for
	temporary file
To: Tristan Schmelcher <tschmelcher@google.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc: user-mode-linux-user@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

QW0gMDguMTIuMjAxNSB1bSAyMTozNyBzY2hyaWViIFRyaXN0YW4gU2NobWVsY2hlcjoKPiBPbiA2
IERlY2VtYmVyIDIwMTUgYXQgMDk6NDMsIE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5l
dD4gd3JvdGU6Cj4+IFdlbGwsIEknbSBjb25jZXJuZWQgdG8gdXNlIHVtYXNrIGJlY2F1c2UgaXQg
aXMgbm90IHRocmVhZC1zYWZlIGFuZCBkcml2ZXJzIG1heSB1c2UgY3JlYXRlX21lbV9maWxlKCkg
aW4gYSBtdWx0aS10aGVhZGVkIGNvbnRleHQuCj4gCj4gWW91IGFyZSByaWdodC4gV2Ugc2hvdWxk
IHBlcmhhcHMgc2V0IHRoZSB1bWFzayB0byAwNzAwIHBlcm1hbmVudGx5Cj4gZHVyaW5nIHByb2Nl
c3Mgc3RhcnQuIEJ1dCBJIGFtIG5vdCBzdXJlIGlmIHRoaXMgd2lsbCBpbnRlcmZlcmUgd2l0aAo+
IG90aGVyIFVNTCBjb2RlLgoKSXQgKnNob3VsZCogbm90IGh1cnQuIExldCdzIHNlZSB3aGF0IGV4
cGxvZGVzLiA6KQoKPj4gSSBwcmVmZXIgdG8gc3RpY2sgdG8gZmNobW9kIGFuZCBoYW5kbGUgdGhl
IHJhY2UtY29uZGl0aW9uIHdpdGggT19UTVBGSUxFIHVuc2VsbCBzb21lb25lIGlzIHN1cmUgdGhh
dCB0aGlzIHdpbGwgbm90IGNyZWF0ZSBidWdzIDopCj4gCj4gVGhlIGZjaG1vZCBjYWxsIGlzIGJh
c2ljYWxseSB1c2VsZXNzIGFuZCBzaG91bGQgcHJvYmFibHkgYmUgcmVtb3ZlZC4KCkkgYWdyZWUu
CgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBt
YWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGlu
dXgtZGV2ZWwK

