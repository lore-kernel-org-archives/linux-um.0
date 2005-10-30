Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWCF2-0003p4-83	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 04:24:52 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EWCF0-0002Ey-Nq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 04:24:52 -0800
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510300624.38794.rob@landley.net>
Subject: [uml-devel] What's wrong with tmpfs?
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
Date: Sun, 30 Oct 2005 06:24:38 -0600
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Under User Mode Linux in 2.6.14, would someone please explain to me why this 
test:

static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
{
        int err;

        if (mnt->mnt_sb->s_flags & MS_NOUSER)
                return -EINVAL;

Is triggering when I try to mount tmpfs?  Is this happening for anybody else?  
Shouldn't I be getting a fresh superblock or something?  (Is this just a User 
Mode Linux issue?  Haven't got a spare box set up to boot it on real hardware 
just yet...)

If somebody needs a reproduction sequence, I'm happy to oblige.  In theory 
"mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it 
wouldn't have shipped...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
