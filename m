Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiHgk-0003TA-Gr for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:22 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AiHgj-00037e-TY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:22 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Dynamic remount with variable COW stacking/merging
	needed, support for snapshot repilication
References: <4009A583.7070007@lig.net>
In-Reply-To: <4009A583.7070007@lig.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181204.04061.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jan 2004 12:04:04 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:13, sabato 17 gennaio 2004, Stephen D. Williams ha scritto:
> When a UML instance is running a always-on service, such as a web
> server, an administrator needs to be able to make live backups, or
> replications, of a running system.
>
> This can be done using LVM snapshots, although that is not always
> appropriate for just this feature. A UML instance can be paused and then
> restarted, but this can cause severe delays while large partitions are
> replicated.
In general, this should be done with LVM. There is a strong idea that COW is 
somehow a duplication of LVM, and I read that Jeff Dike (IIRC) wanted it to 
be rewritten as a new snapshot format for LVM (the reason for a different 
format is that LVM snapshot were built thinking to partitions, while Uml can 
use sparse files - which is a great advantage if you're able to use it).

It's maybe harder to setup, that's true, but see about EVMS which provides a 
nicer interface.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
