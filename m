Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJZ7j-00010L-9A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 08:08:35 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CJZ7i-0003OW-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 08:08:35 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] core dumps and hostfs
References: <8066.1097696719@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <8066.1097696719@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410171534.58416.blaisorblade_spam@yahoo.it>
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
Date: Sun, 17 Oct 2004 15:34:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Wednesday 13 October 2004 21:45, Michael Richardson wrote:
> I have a problem with core dumps under UML.
> It seems that they don't work on hostfs. My guess is that there is
> something in hostfs that doesn't return the right answer.
>
> fs/exec.c, do_coredump(long signr, struct pt_regs * regs) has the
> following code:
>
> 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
> 	if (IS_ERR(file))
> 		goto fail;
> 	inode = file->f_dentry->d_inode;
> %	if (inode->i_nlink > 1)
> %		goto close_fail;	/* multiple links - don't dump */
> 	if (d_unhashed(file->f_dentry))
> 		goto close_fail;
>
> 	if (!S_ISREG(inode->i_mode))
> 		goto close_fail;
> 	if (!file->f_op)
> 		goto close_fail;
> 	if (!file->f_op->write)
> 		goto close_fail;
> 	if (do_truncate(file->f_dentry, 0) != 0)
> 		goto close_fail;
>
> 	retval = binfmt->core_dump(signr, regs, file);
>
> Note that since the file gets created, I looked carefully at what
> happens, and finally I noticed that the file has multiple hard links!
>
> As such that would cause the test at (%) to fail. Look below to
> EXPERIMENT.
>
> Does this make any sense to anyone?
> I did not have this problem with 2.4.19-47.
I think this will not appear with UML versions until 2.4.24-1um included. In 
fact, I'm going to release (don't know when) some 2.4 patches without all the 
hostfs changes, to make it more stable. I'm not seeing, for now, where does 
this come from, but I do not expect the "rewritten" hostfs to work (nor does 
Jeff, for now).

Thanks for the plenty of details, I'll use them later, when debugging this.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
