Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNDh-00068E-JF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:20:37 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BfNDh-0003lb-0o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:20:37 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406291937.18352.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Fixing humfs: the multiple links problem (using hard-
	instead than soft- links in metadata).
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
Date: Tue, 29 Jun 2004 19:37:18 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Well, you speak in your diary about solving it by turning the secondary 
metadata/ files into hardlinks to the main one. However, it seems to me that 
if you make them *hard* links, things become slower. In your idea, you must 
refcount the primary link. And you throw a dice to decide which one is the 
primary (i.e. at an abstraction level, "primary" means nothing).

Instead, with hardlinks, it will work magically; hard-links already implement 
that exact refcount. link() on humfs becomes link() the actual file and 
link() its metadata file, unlink() stays as-is. Coding humsify in bash to 
support either solution (soft- or hard- links) is hard, but if you use the 
perl version someone posted it becomes simpler (well, you must keep an hash 
with inode-numbers and mount-point for files with more than one link, to see 
if two files are links to each other).

If I'm wrong, at least explain why to me and in the diary.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
