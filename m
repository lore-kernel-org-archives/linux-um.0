Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SEc1m-00083c-Ok
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 07:50:15 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SEc1i-0001Zh-Uq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 07:50:14 +0000
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so4019068lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 00:50:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F795309.7030206@debian.org>
References: <0uvj49xgsm.ln2@news.researchut.com>
	<CAFLxGvx2fDWexwA1wmLZ4T0EDaUcaMiROrP-_diQi6bGTNEkyw@mail.gmail.com>
	<4F795309.7030206@debian.org>
Date: Mon, 2 Apr 2012 09:50:10 +0200
Message-ID: <CAFLxGvxiCjYUkjYye8QW_6MRt7VgGrqrJrwN_M375VTGYaUEsg@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=f46d04426e928d701f04bcad708c
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
Subject: Re: [uml-devel] uml build failure on arch i386
To: rrs@debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net

--f46d04426e928d701f04bcad708c
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 2, 2012 at 9:19 AM, Ritesh Raj Sarraf <rrs@debian.org> wrote:
> On Monday 02 April 2012 11:59 AM, richard -rw- weinberger wrote:
>>> > My initial search led me to:
>>> > http://sourceforge.net/mailarchive/message.php?msg_id=27848489
>>> >
>>> > Based on the comment there, I've tried SUBARCH=i386. But that didn't
>>> > help. Any suggestions?
>> Please share your .config.
>
> Config file available at:
> http://people.debian.org/~rrs/tmp/config.i386

Please give the attached patch a try!

-- 
Thanks,
//richard

--f46d04426e928d701f04bcad708c
Content-Type: text/x-patch; charset=US-ASCII; name="x.diff"
Content-Disposition: attachment; filename="x.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0j82jqs1

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3VtL01ha2VmaWxlIGIvYXJjaC94ODYvdW0vTWFrZWZpbGUK
aW5kZXggOGZiNTg0MC4uZjMyMjUwMyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvdW0vTWFrZWZpbGUK
KysrIGIvYXJjaC94ODYvdW0vTWFrZWZpbGUKQEAgLTE5LDcgKzE5LDggQEAgaWZlcSAoJChDT05G
SUdfWDg2XzMyKSx5KQogb2JqLXkgKz0gY2hlY2tzdW1fMzIubwogb2JqLSQoQ09ORklHX0JJTkZN
VF9FTEYpICs9IGVsZmNvcmUubwogCi1zdWJhcmNoLXkgPSAuLi9saWIvc3RyaW5nXzMyLm8gLi4v
bGliL2F0b21pYzY0XzMyLm8gLi4vbGliL2F0b21pYzY0X2N4OF8zMi5vCitzdWJhcmNoLXkgPSAu
Li9saWIvc3RyaW5nXzMyLm8gLi4vbGliL2F0b21pYzY0XzMyLm8gLi4vbGliL2F0b21pYzY0X2N4
OF8zMi5vIFwKKwkuLi9saWIvYXRvbWljNjRfMzg2XzMyLm8gLi4vbGliL2NtcHhjaGc4Yl9lbXUu
bwogc3ViYXJjaC0kKENPTkZJR19SV1NFTV9YQ0hHQUREX0FMR09SSVRITSkgKz0gLi4vbGliL3J3
c2VtLm8KIHN1YmFyY2gtJChDT05GSUdfSElHSE1FTSkgKz0gLi4vbW0vaGlnaG1lbV8zMi5vCiAK
--f46d04426e928d701f04bcad708c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--f46d04426e928d701f04bcad708c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--f46d04426e928d701f04bcad708c--


