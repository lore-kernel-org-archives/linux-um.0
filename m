Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSwKX-0006oU-UX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 09:02:42 -0700
Received: from yx-out-1718.google.com ([74.125.44.153])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSwKX-0004Gs-Bi
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 09:02:41 -0700
Received: by yx-out-1718.google.com with SMTP id 3so954741yxi.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Aug 2008 09:02:40 -0700 (PDT)
Message-ID: <5861bf050808120902s4aabf4fet1c08c1c27aa45823@mail.gmail.com>
Date: Tue, 12 Aug 2008 13:02:39 -0300
From: "=?ISO-8859-1?Q?Roberto_Alc=E2ntara?=" <roberto@eletronica.org>
In-Reply-To: <48A1B2EA.50404@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <5861bf050808120823w483e87eev7ff181eab9c8c026@mail.gmail.com>
	<48A1B2EA.50404@panasas.com>
Subject: Re: [uml-devel] Error starting uml
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Ok Boaz, thank you.
Yes, my gcc version is 4.2.3 and I will do what you say.

All the best,
 - Roberto




On Tue, Aug 12, 2008 at 12:57 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> Roberto Alc=E2ntara wrote:
>> Guys, I'm trying to start uml with website fedora fs.
>> I downloaded 2.6.26 source and build without problems. But when I
>> start I have segmentation fault error.
>>
>
> if gcc on your ubuntu host system is 4.1.x 4.2.x please use
> Linux 2.6.26.2
>
> or specifically add this patch to your Kernel:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3D7c1fed03b9fa32d4323d5caa6a9c7dcdd7eba767
>
>
> Boaz
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
