Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ratheesh.ksz@gmail.com>) id 1OeWLX-0000jA-NH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2010 16:52:39 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OeWLW-0006s0-2a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2010 16:52:39 +0000
Received: by gyd8 with SMTP id 8so260478gyd.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Jul 2010 09:52:32 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 Jul 2010 22:22:32 +0530
Message-ID: <AANLkTi=9OkGhRUso7ehpNMvtTc_FwFvc6=qv9tn6SgNf@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd6ace07eb6e6048c898f45
Subject: [uml-devel] netlink socket is not working
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
To: user-mode-linux-devel@lists.sourceforge.net

--000e0cd6ace07eb6e6048c898f45
Content-Type: text/plain; charset=ISO-8859-1

attached code is working properly on i386 machine running 2.6.32. but
not working on uml (2.6.32 ).

am i missing something ? or is it a known bug ?

--000e0cd6ace07eb6e6048c898f45
Content-Type: text/x-csrc; charset=US-ASCII; name="sock-kernel.c"
Content-Disposition: attachment; filename="sock-kernel.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gc7uc3ku0

I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+CiMgaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KIyBpbmNsdWRlIDxs
aW51eC9uZXRsaW5rLmg+CiMgaW5jbHVkZSA8bmV0L3NvY2suaD4KIyBpbmNsdWRlIDxuZXQvbmV0
X25hbWVzcGFjZS5oPgojIGRlZmluZSBORVRMSU5LX05JVFJPIDE3CgpNT0RVTEVfTElDRU5TRSgi
R1BMIik7CgpzdGF0aWMgc3RydWN0IHNvY2sgKm5sX3NrID0gTlVMTDsKCnN0YXRpYyB2b2lkIG5s
X2RhdGFfcmVhZHkgKHN0cnVjdCBza19idWZmICpza2IpCnsKCiAgIHN0cnVjdCBubG1zZ2hkciAq
bmxoID0gTlVMTDsKICAgaWYoc2tiID09IE5VTEwpIHsKICAgcHJpbnRrKCJza2IgaXMgTlVMTCBc
biIpOwogICByZXR1cm4gOwogICB9CiAgIG5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilza2ItPmRh
dGE7CiAgIHByaW50ayhLRVJOX0lORk8gIiVzOiByZWNlaXZlZCBuZXRsaW5rIG1lc3NhZ2UgcGF5
bG9hZDogJXNcbiIsIF9fRlVOQ1RJT05fXywKICAgICAgICAgICAgICAoY2hhciAqKSBOTE1TR19E
QVRBKG5saCkpOwoKfQoKc3RhdGljIHZvaWQgbmV0bGlua190ZXN0KCkKewoKbmxfc2sgPSBuZXRs
aW5rX2tlcm5lbF9jcmVhdGUoJmluaXRfbmV0LE5FVExJTktfTklUUk8sMCwgbmxfZGF0YV9yZWFk
eSxOVUxMLCBUSElTX01PRFVMRSk7Cgp9CgpzdGF0aWMgaW50IF9faW5pdCBteV9tb2R1bGVfaW5p
dCh2b2lkKQp7CnByaW50ayhLRVJOX0lORk8gIkluaXRpYWxpemluZyBOZXRsaW5rIFNvY2tldCIp
OwpuZXRsaW5rX3Rlc3QoKTsKcmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIF9fZXhpdCBteV9tb2R1
bGVfZXhpdCh2b2lkKQp7CnByaW50ayhLRVJOX0lORk8gIkdvb2RieWUiKTsKc29ja19yZWxlYXNl
KG5sX3NrLT5za19zb2NrZXQpOwp9Cgptb2R1bGVfaW5pdChteV9tb2R1bGVfaW5pdCk7Cm1vZHVs
ZV9leGl0KG15X21vZHVsZV9leGl0KTsK
--000e0cd6ace07eb6e6048c898f45
Content-Type: text/x-csrc; charset=US-ASCII; name="netlink-user.c"
Content-Disposition: attachment; filename="netlink-user.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gc7uckg41

IyBpbmNsdWRlIDxzeXMvdHlwZXMuaD4KIyBpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiMgaW5jbHVk
ZSA8bGludXgvbmV0bGluay5oPgojIGluY2x1ZGUgPHN0ZGxpYi5oPgojIGluY2x1ZGUgPHN0cmlu
Zy5oPgojIGRlZmluZSBORVRMSU5LX05JVFJPIDE3CiMgZGVmaW5lIE1BWF9QQVlMT0FEIDIwNDgg
CmludCBtYWluKCkKewpzdHJ1Y3Qgc29ja2FkZHJfbmwgc19ubGFkZHIsIGRfbmxhZGRyOwpzdHJ1
Y3QgbXNnaGRyIG1zZyA7CnN0cnVjdCBubG1zZ2hkciAqbmxoPU5VTEwgICA7CnN0cnVjdCBpb3Zl
YyBpb3Y7CmludCBmZD1zb2NrZXQoQUZfTkVUTElOSyAsU09DS19SQVcgLCBORVRMSU5LX05JVFJP
ICk7CgovKiBzb3VyY2UgYWRkcmVzcyAqLwptZW1zZXQoJnNfbmxhZGRyLCAwICxzaXplb2Yoc19u
bGFkZHIpKTsKc19ubGFkZHIubmxfZmFtaWx5PSBBRl9ORVRMSU5LIDsKc19ubGFkZHIubmxfcGFk
PTA7CnNfbmxhZGRyLm5sX3BpZCA9IGdldHBpZCgpOwpiaW5kKGZkLCAoc3RydWN0IHNvY2thZGRy
Kikmc19ubGFkZHIsIHNpemVvZihzX25sYWRkcikpOwoKLyogZGVzdGluYXRpb24gYWRkcmVzcyAq
LwptZW1zZXQoJmRfbmxhZGRyLCAwICxzaXplb2YoZF9ubGFkZHIpKTsKZF9ubGFkZHIubmxfZmFt
aWx5PSBBRl9ORVRMSU5LIDsKZF9ubGFkZHIubmxfcGFkPTA7CmRfbmxhZGRyLm5sX3BpZCA9IDA7
ICAvKiBkZXN0aW5lZCB0byBrZXJuZWwgKi8KCi8qIEZpbGwgdGhlIG5ldGxpbmsgbWVzc2FnZSBo
ZWFkZXIgKi8KbmxoID0gKHN0cnVjdCBubG1zZ2hkciAqKW1hbGxvYygxMDApOwptZW1zZXQobmxo
ICwgMCAsIDEwMCk7CnN0cmNweShOTE1TR19EQVRBKG5saCksICIgTXIuIEtlcm5lbCwgQXJlIHlv
dSByZWFkeSA/IiApOwpubGgtPm5sbXNnX2xlbiA9MTAwOwpubGgtPm5sbXNnX3BpZCA9IGdldHBp
ZCgpOwpubGgtPm5sbXNnX2ZsYWdzID0gMTsKbmxoLT5ubG1zZ190eXBlID0gMDsgCgovKmlvdiBz
dHJ1Y3R1cmUgKi8KCmlvdi5pb3ZfYmFzZSA9ICh2b2lkICopbmxoOwppb3YuaW92X2xlbiA9IG5s
aC0+bmxtc2dfbGVuOwoKLyogbXNnICovCm1lbXNldCgmbXNnLDAsc2l6ZW9mKG1zZykpOwptc2cu
bXNnX25hbWUgPSAodm9pZCAqKSAmZF9ubGFkZHIgOwptc2cubXNnX25hbWVsZW49c2l6ZW9mKGRf
bmxhZGRyKTsKbXNnLm1zZ19pb3YgPSAmaW92Owptc2cubXNnX2lvdmxlbiA9IDE7CgpwcmludGYo
Im5saD0lcCBpb3Y9JXAgbXNnPSVwIFxuIiAsIG5saCAsICZpb3YgLCAmbXNnKTsKc2VuZG1zZyhm
ZCwgJm1zZywgMCApOwoKY2xvc2UoZmQpOwpyZXR1cm4gKEVYSVRfU1VDQ0VTUyk7Cn0KCg==
--000e0cd6ace07eb6e6048c898f45
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
--000e0cd6ace07eb6e6048c898f45
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--000e0cd6ace07eb6e6048c898f45--


