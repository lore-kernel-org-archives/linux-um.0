Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1s4W-0004te-Sh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 12:44:08 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1s4S-0001Jd-2s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 12:44:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408302140.15460.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] UML merge in after 2.6.8.1 - what to do now
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
Date: Mon, 30 Aug 2004 21:40:15 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I've just seen in my mailbox the mails from Andrew Morton to Linus Torvalds, 
which contain the UML merge - 2.6.9-rc1-mm1 already lists them as merged, as 
you can check here: http://kerneltrap.org/node/view/3720

Now, how will we work? I have some ideas about this, which I'd like to discuss 
with everybody here. I think that the UML patch will become the "development 
tree" of UML, where new patches hang around to get some testing, while the 
mainline kernel should get only safe patches. For instance, for now the humfs 
and filehandle work must *not* go in mainline, since they are highly 
experimental.

Also, the various uml patch should never be actually "merged" inside the UML 
patch: it must always be a patchset, i.e. a collection of separate patches. 
Like -mm. So merging with mainline will be easier, as reviewing separate 
patches or dropping bad ones.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
