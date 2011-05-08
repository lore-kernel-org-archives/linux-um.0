Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1QJC9d-0002LG-AD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2011 22:08:45 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QJC9c-0001y2-6h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2011 22:08:45 +0000
Received: by qwh5 with SMTP id 5so3867178qwh.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 May 2011 15:08:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DC4398C.2070307@fnac.net>
References: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
	<BANLkTimDwsBk-MvFFABgf0kzx3WHkt6uMA@mail.gmail.com>
	<4DC4398C.2070307@fnac.net>
Date: Mon, 9 May 2011 00:08:38 +0200
Message-ID: <BANLkTik-ouZ1a1fBJNwYsOjF0ve2ucbTig@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH] for ARCH=um,
 optionaly give a path for the vde installation.
To: Paul Chavent <paul.chavent@fnac.net>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Hi,

On Fri, May 6, 2011 at 8:10 PM, Paul Chavent <paul.chavent@fnac.net> wrote:
> On 05/06/2011 09:52 AM, richard -rw- weinberger wrote:
>>
>> On Thu, May 5, 2011 at 9:34 AM,<paul.chavent@fnac.net> =A0wrote:
>>>
>>> Hi.
>>>
>>> I use uml with vde. The kernel links against libvdeplug.a and
>>> automatically find it. But i would like to manually give its path.
>>>
>>> So i made a patch for being able to give the VDE_PREFIX when we call
>>> make.
>>>
>>> I wonder if this patch could be included in the mainstream kernel, or if
>>> there is a better way of doing it.
>>>
>>> Could you give me your opinion please ?
>>
>> Please post your patch.
>> Otherwise nobody can review it.
>>
> Damned
>
> thank you for reminding me :)
>

Please submit patches not as attachment.
See:
Documentation/SubmittingPatches
http://www.youtube.com/watch?v=3DLLBrBBImJt4
http://kapare.blogspot.com/2009/09/write-and-submit-your-first-kernel.html

Anyway, your patch makes use of "CFLAGS_vde_user.o",
where is this variable used?

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network =

management toolset available today.  Delivers lowest initial =

acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

