Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASwU0-0007dM-6U
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 02:49:48 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ASwTz-0006ym-LZ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 02:49:47 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] updating 2.6 to merge 2.4 changes(was: Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash)
References: <Pine.LNX.4.44.0312060951220.13277-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0312060951220.13277-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312071153.33410.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 7 Dec 2003 11:53:33 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 10:41, sabato 6 dicembre 2003, Henrik Nordstrom ha scritto:
> On Fri, 5 Dec 2003, Jeff Dike wrote:
> > It would be useful for someone to start a new UML tree, collect patches,
> > merge them in, get testing, and forward them on to me.  But so far,
> > pretty much no one is in the code but me, so you're limited by the time
> > that I can put into it.
I've given a diff to 2.6 vs. 2.4 UML trees, and discovered that the sources, 
in many sections, are pretty much the same. For instance, in the drivers 
folder we have many not forwarded diffs, and only one like that was a real 
difference between them(i.e. a change to use workqueues instead of task 
queues, IIRC). Do you think using a common code base and insulating the 
different things inside the 2_5compat.h header(since you created it, I 
suppose this was the meaning) would be a bad idea?

If you saved all the diffs you applied it should be ok, however redoing any 
change probably isn't worth...

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
