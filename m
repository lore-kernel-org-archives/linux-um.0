Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Avu4C-0007Yk-8K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 00:06:52 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user18657)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Avtik-0002gA-K3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Feb 2004 23:44:42 -0800
Subject: Re: [uml-user] Re: [uml-devel] new skas3 patch ready for 2.4.25
References: <40338C1B.1070800@meisterwerk.net>
	<200402221516.09898.blaisorblade_spam@yahoo.it>
	<87u11jrnwk.fsf@amaterasu.srvr.nix>
	<200402222056.30704.blaisorblade_spam@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200402222056.30704.blaisorblade_spam@yahoo.it> (BlaisorBlade's
	message of "Sun, 22 Feb 2004 20:56:30 +0100")
Message-ID: <87fzczsi9z.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 25 Feb 2004 07:57:44 +0000
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 22 Feb 2004, BlaisorBlade mused:
> When analyzing your bug I was really astonished - I thought at a such scenario 
> ( 1st build without CONFIG_PROC_MM created ptrace.o but then failed - config 
> updated - rebuild all but ptrace.o is not rebuilt) and posted my answer in 
> that hypothesis, but I thought that was too hard to trigger and that I had 
> made some errors.

... and after a full rebuild it works. It's easy to trigger that scenario
if one is sufficiently distracted when building :)

Blasted blasted dependencies.

> Good bye and best wishes for your new kernel!

She lives, she lives!

-- 
`note to the crown prosecution service: Machine guns dont have a
 'stun' setting.' --- mjw


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
