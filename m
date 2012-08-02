Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Swq3H-0000m7-Ik
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2012 07:42:35 +0000
Received: from mail-gg0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Swq3D-0007i2-Rg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2012 07:42:35 +0000
Received: by ggnp4 with SMTP id p4so8336083ggn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 02 Aug 2012 00:42:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMQPmcCJDkBFRLGY861fVDN2W4=71hxK2+buLcPDt938ccUupA@mail.gmail.com>
References: <50179725.9cO+m/nAt3rcNdV1%vleclement@gmail.com>
	<5019B30B.8010306@sigma-star.at>
	<CAMQPmcCJDkBFRLGY861fVDN2W4=71hxK2+buLcPDt938ccUupA@mail.gmail.com>
Date: Thu, 2 Aug 2012 09:42:26 +0200
Message-ID: <CAFLxGvwBixt9t9cy7-NBRZ=HHo143rx2CdwMB_EOY8+94_rT_A@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: fix missing include with glibc 2.16
To: =?ISO-8859-1?Q?Vianney_le_Cl=E9ment?= <vleclement@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Aug 2, 2012 at 8:53 AM, Vianney le Cl=E9ment <vleclement@gmail.com>=
 wrote:
> On Thu, Aug 2, 2012 at 12:51 AM, Richard Weinberger
> <richard@sigma-star.at> wrote:
>> On 31.07.2012 10:28, Vianney le Cl=E9ment de Saint-Marcq wrote:
>>>
>>> From: Vianney le Cl=E9ment de Saint-Marcq <vleclement@gmail.com>
>>>
>>> As of glibc 2.16, sys/wait.h does no longer include sys/resource.h,
>>> which is needed for getrlimit(). This patch fixes compiling UML with
>>> glibc 2.16.
>>>
>>> Signed-off-by: Vianney le Cl=E9ment de Saint-Marcq <vleclement@gmail.co=
m>
>>
>>
>> Sorry, I cannot apply this patch.
>> It's base64 encoded.
>>
>> Can you please send it using git?
>
> Weird, I used heirloom-mailx to try to avoid such problems. I'll try
> to resend the patch using git and another smtp server.

As it's a trivial patch you can also send it s attachment.
(If nothing else works)

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

