Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L2ryc-0005lT-Of
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Nov 2008 18:40:34 +0000
Received: from ug-out-1314.google.com ([66.249.92.171])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L2ryb-0007PR-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Nov 2008 18:40:34 +0000
Received: by ug-out-1314.google.com with SMTP id 36so62623uga.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 19 Nov 2008 10:40:31 -0800 (PST)
Date: Wed, 19 Nov 2008 18:40:14 +0000
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20081119184014.GD22898@hack.voiplan.pt>
References: <20081118174250.GE3185@hack.voiplan.pt>
	<20081118192626.GU28946@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081118192626.GU28946@ZenIV.linux.org.uk>
Subject: Re: [uml-devel] [Patch] uml: fix undeclared variables
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
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Am??rico Wang <xiyou.wangcong@gmail.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

T24gVHVlLCBOb3YgMTgsIDIwMDggYXQgMDc6MjY6MjZQTSArMDAwMCwgQWwgVmlybyB3cm90ZToK
Pk9uIFR1ZSwgTm92IDE4LCAyMDA4IGF0IDA1OjQyOjUxUE0gKzAwMDAsIEFtPz9yaWNvIFdhbmcg
d3JvdGU6Cj4+IAo+PiBGaXggdGhyZWUgY29tcGlsZSBlcnJvcnMgYWJvdXQgdW5kZWNsYXJlZCB2
YXJpYWJsZXMgaW4KPj4gYXJjaC91bS9rZXJuZWwvbWVtLmMuCj4KPkFuZCB3aGF0LCBwcmF5IHRl
bGwsIHdvdWxkIGluaXRpYWxpemUgaXQ/CgpTb3JyeSwgSSBjYW4ndCBmdWxseSB1bmRlcnN0YW5k
IHlvdS4gSSBnb3QgdGhlIGZvbGxvd2luZyBlcnJvcjoKCmFyY2gvdW0va2VybmVsL21lbS5jOiBJ
biBmdW5jdGlvbiDigJhpbml0X2hpZ2htZW3igJk6CmFyY2gvdW0va2VybmVsL21lbS5jOjE3Nzog
ZXJyb3I6IOKAmHBrbWFwX3BhZ2VfdGFibGXigJkgdW5kZWNsYXJlZCAoZmlyc3QKdXNlIGluIHRo
aXMgZnVuY3Rpb24pCmFyY2gvdW0va2VybmVsL21lbS5jOjE3NzogZXJyb3I6IChFYWNoIHVuZGVj
bGFyZWQgaWRlbnRpZmllciBpcwpyZXBvcnRlZCBvbmx5IG9uY2UKYXJjaC91bS9rZXJuZWwvbWVt
LmM6MTc3OiBlcnJvcjogZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCgpUaGFua3Mu
CgotLSAKIlNvbWV0aW1lcyB0aGUgb25seSB3YXkgdG8gc3RheSBzYW5lIGlzIHRvIGdvIGEgbGl0
dGxlIGNyYXp5LiIKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNwb25z
b3JlZCBieSB0aGUgTW9ibGluIFlvdXIgTW92ZSBEZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVpbGQg
dGhlIGNvb2xlc3QgTGludXggYmFzZWQgYXBwbGljYXRpb25zIHdpdGggTW9ibGluIFNESyAmIHdp
biBncmVhdCBwcml6ZXMKR3JhbmQgcHJpemUgaXMgYSB0cmlwIGZvciB0d28gdG8gYW4gT3BlbiBT
b3VyY2UgZXZlbnQgYW55d2hlcmUgaW4gdGhlIHdvcmxkCmh0dHA6Ly9tb2JsaW4tY29udGVzdC5v
cmcvcmVkaXJlY3QucGhwP2Jhbm5lcl9pZD0xMDAmdXJsPS8KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcg
bGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZl
bAo=
