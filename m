Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijs5J-0007rq-NL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 00:52:33 -0700
Received: from ag-out-0708.google.com ([72.14.246.249])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ijs5I-0000xb-8c
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 00:52:25 -0700
Received: by ag-out-0708.google.com with SMTP id 23so2164279agd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Oct 2007 00:52:21 -0700 (PDT)
Date: Mon, 22 Oct 2007 15:48:23 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071022074823.GJ2998@hacking>
References: <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022065943.GC10864@uranus.ravnborg.org>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in	2.6.23-final.
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>

T24gTW9uLCBPY3QgMjIsIDIwMDcgYXQgMDg6NTk6NDNBTSArMDIwMCwgU2FtIFJhdm5ib3JnIHdy
b3RlOgo+T24gTW9uLCBPY3QgMjIsIDIwMDcgYXQgMDI6NTI6MDJQTSArMDgwMCwgV0FORyBDb25n
IHdyb3RlOgo+PiBPbiBNb24sIE9jdCAyMiwgMjAwNyBhdCAwNzo0MjozM0FNICswMTAwLCBOaXgg
d3JvdGU6Cj4+ID5PbiAyMiBPY3QgMjAwNywgV0FORyBDb25nIHV0dGVyZWQgdGhlIGZvbGxvd2lu
ZzoKPj4gPj4gSSBidWlsZCBVTUwgZm9yIG5vbi1TTVAgeDg2LiBCdXQgSSBkb24ndCBrbm93IGFi
b3V0IFVNTF9ORVRfVkRFLiA7KAo+PiA+Pgo+PiA+PiBFcnJvcnMgdGhyZXcgb3V0IGJ5IGdjYyAo
dG9vIG1hbnkpIGFyZSBwdXQgaGVyZToKPj4gPj4gCWh0dHA6Ly93YW5nY29uZy5vcmcvZG93bi9l
cnJvcnMudHh0Cj4+ID4KPj4gPkl0J3MgaGFyZCB0byB0ZWxsIHdpdGhvdXQgTE9DQUxFPUMsIGJ1
dCB0aG9zZSBhcmUgdGhlIHNvcnRzIG9mIHJlc3VsdHMKPj4gPkknZCBleHBlY3QgaWYgeW91IGhh
ZCBydW4gbWFrZSB7b2xkLG1lbnUseH1jb25maWcgd2l0aG91dCBzcGVjaWZ5aW5nCj4+ID5BUkNI
PXVtLCBzbyB5b3UndmUgY29uZmlndXJlZCBmb3Igb25lIGFyY2hpdGVjdHVyZSBhbmQgYXJlIG5v
dyB0cnlpbmcKPj4gPnRvIGJ1aWxkIGFub3RoZXIuCj4+ID4KPj4gPldoZXJlIGlzIHRoZSBpbmNs
dWRlL2FzbSBzeW1saW5rIHBvaW50aW5nIHRvIGluIHlvdXIgYnVpbGQgdHJlZT8KPj4gCj4+ICQg
bHMgLWwgaW5jbHVkZS9hc20KPj4gbHJ3eHJ3eHJ3eCAxIHdhbmdjb25nIHdhbmdjb25nIDYgMjAw
Ny0xMC0yMiAxMjozNCBpbmNsdWRlL2FzbSAtPiBhc20tdW0KPj4gCj4+IE9LLiBMZXQgbWUgZG8g
dGhlIGZvbGxvd2luZzoKPj4gCj4+IAkkIG1ha2UgbXJwcm9wZXIKPgo+UGxlYXNlIHRyeQo+bWFr
ZSBBUkNIPXVtIG1ycHJvcGVyCj4KPnRoaXMgd2lsbCBjbGVhbiB1cCB0aGUgYWRkaXRpb25hbCB1
bWwgc3ltbGlua3MuCj4KCkhpLCBTYW0sIEFsIGFuZCBvdGhlcnMuCgpJIGp1c3QgZm9sbG93ZWQg
d2hhdCBTYW0gdG9sZCBtZSwgZXJyb3JzIGFyZSBtdWNoIGZld2VyIHRoaXMgdGltZSwKYnV0IHN0
aWxsIGV4aXN0LiBFcnJvciBtZXNzYWdlcyBhcmU6CgogIENDICAgICAgYXJjaC91bS9rZXJuZWwv
c3lzY2FsbC5vCiAgQ0MgICAgICBhcmNoL3VtL2tlcm5lbC9zeXNycS5vCmFyY2gvdW0va2VybmVs
L3N5c3JxLmM6IEluIGZ1bmN0aW9uIOKAmHNob3dfc3RhY2vigJk6CmFyY2gvdW0va2VybmVsL3N5
c3JxLmM6NjM6IGVycm9yOiDigJhVRVNQ4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlz
IGZ1bmN0aW9uKQphcmNoL3VtL2tlcm5lbC9zeXNycS5jOjYzOiBlcnJvcjogKEVhY2ggdW5kZWNs
YXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZQphcmNoL3VtL2tlcm5lbC9zeXNy
cS5jOjYzOiBlcnJvcjogZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCm1ha2VbMV06
ICoqKiBbYXJjaC91bS9rZXJuZWwvc3lzcnEub10gRXJyb3IgMQptYWtlOiAqKiogW2FyY2gvdW0v
a2VybmVsXSBFcnJvciAyCgpPciBJIG1pc3NlZCBzb21ldGhpbmcgYWdhaW4/CgpBbmQgSSB1c2Ug
YG1ha2UgZGVmY29uZmlnIEFSQ0g9dW0nIHRvIGdlbmVyYXRlIC5jb25maWcsIG15IHRyZWUKaXMg
Mi42LjIzLWdpdDE2IChBbCwgaXMgdGhpcyBPSz8pLgoKVGhhbmtzLgoKLS0gCk1heSB0aGUgU291
cmNlIEJlIFdpdGggWW91LgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBz
cG9uc29yZWQgYnk6IFNwbHVuayBJbmMuClN0aWxsIGdyZXBwaW5nIHRocm91Z2ggbG9nIGZpbGVz
IHRvIGZpbmQgcHJvYmxlbXM/ICBTdG9wLgpOb3cgU2VhcmNoIGxvZyBldmVudHMgYW5kIGNvbmZp
Z3VyYXRpb24gZmlsZXMgdXNpbmcgQUpBWCBhbmQgYSBicm93c2VyLgpEb3dubG9hZCB5b3VyIEZS
RUUgY29weSBvZiBTcGx1bmsgbm93ID4+IGh0dHA6Ly9nZXQuc3BsdW5rLmNvbS8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRl
dmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9k
ZS1saW51eC1kZXZlbAo=
