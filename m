Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vleclement@gmail.com>) id 1SxIIK-0001Cx-CL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2012 13:52:00 +0000
Received: from mail-gh0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SxIIG-0005Hu-PC
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2012 13:52:00 +0000
Received: by ghbz2 with SMTP id z2so821941ghb.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 03 Aug 2012 06:51:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwBixt9t9cy7-NBRZ=HHo143rx2CdwMB_EOY8+94_rT_A@mail.gmail.com>
References: <50179725.9cO+m/nAt3rcNdV1%vleclement@gmail.com>
	<5019B30B.8010306@sigma-star.at>
	<CAMQPmcCJDkBFRLGY861fVDN2W4=71hxK2+buLcPDt938ccUupA@mail.gmail.com>
	<CAFLxGvwBixt9t9cy7-NBRZ=HHo143rx2CdwMB_EOY8+94_rT_A@mail.gmail.com>
From: =?ISO-8859-1?Q?Vianney_le_Cl=E9ment?= <vleclement@gmail.com>
Date: Fri, 3 Aug 2012 15:51:30 +0200
Message-ID: <CAMQPmcALSGx4CNyN5N62Tcu_yKgSHWergYg4CiSHB6fcb=_sPw@mail.gmail.com>
Content-Type: multipart/mixed; boundary=14dae9340a8d79f28204c65cd431
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
Subject: Re: [uml-devel] [PATCH] um: fix missing include with glibc 2.16
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--14dae9340a8d79f28204c65cd431
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 2, 2012 at 9:42 AM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> As it's a trivial patch you can also send it s attachment.
> (If nothing else works)

Hi Richard,

Did you receive the patch sent by git? In any case, I have attached it
to this mail.

Vianney

--14dae9340a8d79f28204c65cd431
Content-Type: application/octet-stream; name="glibc2.16.patch"
Content-Disposition: attachment; filename="glibc2.16.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h5fbyz8i0

VGhlIFBPU0lYIG1hbnBhZ2UgZm9yIGdldHJsaW1pdCgzKSByZXF1aXJlcyBzeXMvcmVzb3VyY2Uu
aCB0byBiZQppbmNsdWRlZC4gVGhpcyBoZWFkZXIgdXNlZCB0byBiZSBpbmNsdWRlZCBieSBzeXMv
d2FpdC5oIGluIGdsaWJjLgpBcyBvZiBnbGliYyAyLjE2IGhvd2V2ZXIsIHRoaXMgaXMgbm90IHRo
ZSBjYXNlIGFueW1vcmUsIHRodXMgYnJlYWtpbmcKdGhlIGNvbXBpbGF0aW9uLgoKU2lnbmVkLW9m
Zi1ieTogVmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcSA8dmxlY2xlbWVudEBnbWFp
bC5jb20+Ci0tLQogYXJjaC91bS9vcy1MaW51eC9zdGFydF91cC5jIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9hcmNoL3VtL29zLUxpbnV4L3N0YXJ0
X3VwLmMgYi9hcmNoL3VtL29zLUxpbnV4L3N0YXJ0X3VwLmMKaW5kZXggNDI1MTYyZS4uNjc3MDRh
YiAxMDA2NDQKLS0tIGEvYXJjaC91bS9vcy1MaW51eC9zdGFydF91cC5jCisrKyBiL2FyY2gvdW0v
b3MtTGludXgvc3RhcnRfdXAuYwpAQCAtMTMsNiArMTMsNyBAQAogI2luY2x1ZGUgPHNpZ25hbC5o
PgogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPHN5cy9tbWFuLmg+CisjaW5jbHVkZSA8
c3lzL3Jlc291cmNlLmg+CiAjaW5jbHVkZSA8c3lzL3N0YXQuaD4KICNpbmNsdWRlIDxzeXMvd2Fp
dC5oPgogI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4KLS0gCjEuNy4xMS40Cg==
--14dae9340a8d79f28204c65cd431
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--14dae9340a8d79f28204c65cd431
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--14dae9340a8d79f28204c65cd431--


