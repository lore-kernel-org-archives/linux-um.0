Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ3lv-0004T9-T1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 02:58:07 -0700
Received: from nf-out-0910.google.com ([64.233.182.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ3lu-0005aG-Fz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 02:58:07 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1574466nfd.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 02:58:05 -0700 (PDT)
Message-ID: <6d291e080807160258i2307b009i6295ebe273db1640@mail.gmail.com>
Date: Wed, 16 Jul 2008 04:58:04 -0500
From: "Stoyan Gaydarov" <stoyboyker@gmail.com>
In-Reply-To: <20080715163216.GD12154@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <6d291e080807110053r3980a9dav226c6ea9d8e0b9af@mail.gmail.com>
	<20080715163216.GD12154@c2.user-mode-linux.org>
Subject: [SPAM]  Re: [uml-devel] Build Errors
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jul 15, 2008 at 11:32 AM, Jeff Dike <jdike@addtoit.com> wrote:
> On Fri, Jul 11, 2008 at 02:53:09AM -0500, Stoyan Gaydarov wrote:
>> If I did these builds wrong then do let me know what I can
>> do to fix them and re-run them so that I can provide some useful
>> information in the future.
>
> There's not a lot of point to tarring up 17 logs when there are only
> four distinct failures.  Two of them were due to you not having pcap
> or VDE installed on the host.
>
> The next most common one looks like SMP getting turned on somehow.
>
> There's one with some undefined symbols at the very end, which I have
> never seen before.

I am glad I could help with this even though the rest of the logs were
pretty much useless. Any suggestions on what I can do to actually do
this correctly would be greatly apreciated.
>
>                        Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
