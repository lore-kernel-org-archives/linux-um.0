Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2dsS-0001Iq-J2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Sep 2004 15:46:52 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C2dsR-0002d2-O3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Sep 2004 15:46:52 -0700
Message-ID: <06f501c49076$d750e480$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040830203549.E13DBBD38@zion.localdomain>
	<Pine.LNX.4.58.0409011138180.1678@gradall.private.brainfood.com>
Subject: Re: [uml-devel] [patch 2/4] proc_sysemu
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 2 Sep 2004 00:55:55 +0200
To: Adam Heath <doogie@debian.org>, blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

hi!

> Er, why?  This could cause the emulated system to cause higher load on the
> host, which seems bad to me.
right - so just don`t touch it ! :)

for example it`s meant for people to compare performance with and without sysemu. saves them a lot of time because they won`t need
to reboot their uml to switch that feature on/off.
that feature is not meant for production usage. when time goes by and sysemu has gotten quite "common" or "mature" , maybe
/proc/sysemu will be removed again.

roland


----- Original Message ----- 
From: "Adam Heath" <doogie@debian.org>
To: <blaisorblade_spam@yahoo.it>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; <for_spam@gmx.de>
Sent: Wednesday, September 01, 2004 6:38 PM
Subject: Re: [uml-devel] [patch 2/4] proc_sysemu


> On Mon, 30 Aug 2004,  wrote:
>
> >
> > From: "roland" <for_spam@gmx.de> and me.
> > Adds /proc/sysemu to toggle SYSEMU usage at runtime.
>
> Er, why?  This could cause the emulated system to cause higher load on the
> host, which seems bad to me.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
