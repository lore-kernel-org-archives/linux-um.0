Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <torvalds@linux-foundation.org>) id 1P0hFQ-0008TB-60
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 20:58:00 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0hFP-0007KI-4m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 20:58:00 +0000
Received: from mail-iw0-f175.google.com (mail-iw0-f175.google.com
	[209.85.214.175]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id o8SKvOq8012658
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Sep 2010 13:57:25 -0700
Received: by iwn2 with SMTP id 2so133272iwn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Sep 2010 13:57:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100928134721.f79a5955.akpm@linux-foundation.org>
References: <4CA09977.80506@panasas.com>
	<AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
	<20100928134721.f79a5955.akpm@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Sep 2010 13:57:04 -0700
Message-ID: <AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
Content-Type: multipart/mixed; boundary=0016364ece5684ec7504915817ba
Subject: Re: [uml-devel] {painfully BISECTED} Please revert f25c80a4b2:
 arch/um/drivers: remove duplicate structure field initialization
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

--0016364ece5684ec7504915817ba
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 1:47 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> And I misread that, assuming that it's just a wrapper around
> eth_mac_addr(). =A0Only it isn't, because it passes eth_mac_addr() the
> MAC address's address directly (with ->sa_data). =A0But eth_mac_addr()
> expects a `struct sockaddr *'.
>
> And for some wtf reason, eth_mac_addr() passes that `struct
> sockaddr *' in a `void *', thus cunningly hiding the bug.
>
> Yeah, please revert it.

Well, the alternative would be to just fix uml_net_set_mac(). The code
before the patch was clearly crap too, so reverting may make it work,
but gets us back to a stupid situation with two different initializers
for one field.

So perhaps something like the attached patch would make it work, and
have the locking in place that apparently people think it should have?

Boaz?

                     Linus

--0016364ece5684ec7504915817ba
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gen8xns60

IGFyY2gvdW0vZHJpdmVycy9uZXRfa2Vybi5jIHwgICAgNiArKystLS0KIDEgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0v
ZHJpdmVycy9uZXRfa2Vybi5jIGIvYXJjaC91bS9kcml2ZXJzL25ldF9rZXJuLmMKaW5kZXggMmFi
MjMzYi4uZTQ0ZmQ4NyAxMDA2NDQKLS0tIGEvYXJjaC91bS9kcml2ZXJzL25ldF9rZXJuLmMKKysr
IGIvYXJjaC91bS9kcml2ZXJzL25ldF9rZXJuLmMKQEAgLTI1NywxNCArMjU3LDE0IEBAIHN0YXRp
YyB2b2lkIHVtbF9uZXRfdHhfdGltZW91dChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogCiBzdGF0
aWMgaW50IHVtbF9uZXRfc2V0X21hYyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB2b2lkICphZGRy
KQogeworCWludCByZXQ7CiAJc3RydWN0IHVtbF9uZXRfcHJpdmF0ZSAqbHAgPSBuZXRkZXZfcHJp
dihkZXYpOwotCXN0cnVjdCBzb2NrYWRkciAqaHdhZGRyID0gYWRkcjsKIAogCXNwaW5fbG9ja19p
cnEoJmxwLT5sb2NrKTsKLQlldGhfbWFjX2FkZHIoZGV2LCBod2FkZHItPnNhX2RhdGEpOworCXJl
dCA9IGV0aF9tYWNfYWRkcihkZXYsIGFkZHIpOwogCXNwaW5fdW5sb2NrX2lycSgmbHAtPmxvY2sp
OwogCi0JcmV0dXJuIDA7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIGludCB1bWxfbmV0X2No
YW5nZV9tdHUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IG5ld19tdHUpCg==
--0016364ece5684ec7504915817ba
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--0016364ece5684ec7504915817ba
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--0016364ece5684ec7504915817ba--


