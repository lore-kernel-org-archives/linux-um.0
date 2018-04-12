Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard@nod.at>) id 1f6VuT-0007Wg-Gr
 for user-mode-linux-devel@lists.sourceforge.net;
 Thu, 12 Apr 2018 06:40:41 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6VuR-009oZp-Fg for user-mode-linux-devel@lists.sourceforge.net;
 Thu, 12 Apr 2018 06:40:41 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 12 Apr 2018 08:40:30 +0200
Message-ID: <9086376.yYHLv4WMPf@blindfold>
In-Reply-To: <20180329204559.14113-1-richard@nod.at>
References: <20180329204559.14113-1-richard@nod.at>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: Fix return value of start_idle_thread
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
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
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org

QW0gRG9ubmVyc3RhZywgMjkuIE3DpHJ6IDIwMTgsIDIyOjQ1OjU5IENFU1Qgc2NocmllYiBSaWNo
YXJkIFdlaW5iZXJnZXI6Cj4gV2hpbGUgdGhlIGZ1bmN0aW9uIHdpbGwgbmV2ZXIgcmV0dXJucywg
Z2NjIHdpbGwgd2FybnMuCj4gQWRkIGEgcmV0dXJuIHN0YXRlbWVudCB0byBtYWtlIGdjYyBoYXBw
eS4KPiBCZWZvcmUgZjQ0ZjFlN2RhN2M4IHdlIG5ldmVyIG5vdGljZWQgYmVjYXVzZSBnY2Mga25v
d3MgdGhhdCBsb25nam1wIGRvZXMKPiBub3QgcmV0dXJuLgo+IAo+IGFyY2gvdW0vb3MtTGludXgv
c2thcy9wcm9jZXNzLmM6IEluIGZ1bmN0aW9uIOKAmHN0YXJ0X2lkbGVfdGhyZWFk4oCZOgo+IGFy
Y2gvdW0vb3MtTGludXgvc2thcy9wcm9jZXNzLmM6NjEzOjE6IHdhcm5pbmc6IGNvbnRyb2wgcmVh
Y2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rpb24gWy1XcmV0dXJuLXR5cGVdCj4gCj4gRml4ZXM6
IGY0NGYxZTdkYTdjOCAoInVtOiBBdm9pZCBsb25nam1wL3NldGptcCBzeW1ib2wgY2xhc2hlcyB3
aXRoIGxpYnB0aHJlYWQuYSIpCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxy
aWNoYXJkQG5vZC5hdD4KCkFwcGxpZWQuCgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBvbmUgb2Yg
dGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmchIGh0dHA6
Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1s
aW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

