Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEHh7-0007se-2W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:03:33 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DEHh5-0007mQ-9H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:03:32 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Hostfs permission checks are all wonky.
References: <200503201417.59739.rob@landley.net>
	<200503222019.10709.blaisorblade@yahoo.it>
	<200503230313.06299.rob@landley.net>
In-Reply-To: <200503230313.06299.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240302.47806.blaisorblade@yahoo.it>
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
Date: Thu, 24 Mar 2005 03:02:47 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 23 March 2005 09:13, Rob Landley wrote:
> On Tuesday 22 March 2005 02:19 pm, Blaisorblade wrote:
> > Ok, I'm now seeing that UML uses access() (inside access_file()) to check
> > permissions.
> >
> > See hostfs_permission -> access_file -> access. hostfs_permission (not
> > access_file) should skip the "access_file" call in case its type is
> > OS_TYPE_CHARDEV / OS_TYPE_BLOCKDEV / OS_TYPE_FIFO / OS_TYPE_SOCK.
> >
> > Look at init_inode() about how to see the file's type, but even better
> > look at the cached information, i.e. inode->i_mode and the S_* access
> > macro (look at init_special_inode about this).
>
> Just confirming: this patch fixed it.  Both /dev/loop0 and /dev/console
> work just fine with hostfs root now.
>
> Can this patch make it into 2.6.12?
Yes, it's on his way (in next group of merges however).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
