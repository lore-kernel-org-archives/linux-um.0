Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiPUd-0001Yl-Uj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 20:22:39 -0700
Received: from out-mta1.plasa.com ([202.134.0.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BiPUd-0007qW-0q for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 20:22:39 -0700
From: "Mulyadi-Santosa" <a_mulyadi@telkom.net>
Subject: Re: [uml-devel] problem with hostfs in statfs... (2.6.7)
Message-ID: <web-690734@b1.c.plasa.com>
In-Reply-To: <16f5f6240407071914138341e3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Transfer-Encoding: 8bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 08 Jul 2004 10:22:12 +0700
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Eddy Yuniar <dogmaphobia@gmail.com>

hello Eddy

>I''ve runnning a problem when invoking df from the 
>shell.... and got
>kernel panic...
:-) You got the stack trace then?

>the problem is in hostfs_statfs when calling do_statfs, 
>parameter
>sf->f_spare should be substituted with sf->f_frsize, 
>because there is
>a change in struct kstatfs with addition f_frsize that 
>using one of
>f_spare array.... so array f_spare now only have size 
>5....

nice thinking.......creating a small patch for this won't 
be difficult right?

NB: Are you from ITS Surabaya?

regards

Mulyadi
===========================================================================================
Netkuis Instan untuk wilayah Bandung (kode area 022) - SD,SMP,SMA berhadiah total puluhan juta rupiah... periode I dimulai 1 April 2004
===========================================================================================


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
