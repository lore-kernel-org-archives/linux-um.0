Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOLPl-0006pt-MV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:12:17 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOLPl-0004IV-2V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:12:17 -0800
Date: Mon, 5 Mar 2007 17:03:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070305220334.GB7702@ccure.user-mode-linux.org>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
	<20070305204902.9072.1224.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070305204902.9072.1224.stgit@americanbeauty.home.lan>
Subject: Re: [uml-devel] [PATCH 04/11] uml - hostfs: avoid possible escapes
	from hostfs=.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 05, 2007 at 09:49:02PM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Avoid accepting things like -o .., -o dir/../../dir2, -o dir/../.. .
> This may be considered useless, but YMMV. I consider that this has a limited
> security value, exactly like disabling module support (in many case it is
> useful).

Two comments on this one:

> +	return  strstr(path, "/../") != NULL ||
> +		strcmp(path, "..") == 0 ||
> +		strncmp(path, "../", strlen("../")) == 0 ||
> +		str_ends_with(path, "/..");

Minor style point - I'd be happier with more parens:

+	return  (strstr(path, "/../") != NULL) ||
+		(strcmp(path, "..") == 0) ||
+		(strncmp(path, "../", strlen("../")) == 0) ||
+		str_ends_with(path, "/..");

C gets operator precedence wrong in one or two cases, so I just put parens
any place it might matter.

Second, there is code in externfs which does the same thing without
parsing paths which you might consider instead.  It sees whether the
requested directory is outside the jail by cd-ing to it and then
repeatedly cd .. until it either reaches / or the jail root.

A copy is below for your reading pleasure.

				Jeff

-- 
Work email - jdike at linux dot intel dot com


/* This does a careful check of whether it's being asked to mount something
 * that's outside the hostfs jail.  It does so by cd-ing to the requested
 * directory and "cd .." until it either reaches / or the jail directory.
 * If it reaches /, then we were outside the jail and we return -EPERM.
 * I do things this way rather than trying to examine the passed-in root
 * to avoid having to parse the string for instances of ".." and the like.
 * Examining the string also doesn't help with symlinks that point outside
 * the jail.  Plus, if there's no parsing, there's no parser to try to exploit.
 */
static int escaping_jail(char *root)
{
	struct uml_stat jail_inode;
	struct uml_stat last_dir, cur_dir;
	int save_pwd, err, escaping = -EPERM;
	const char *path[] = { jail_dir, root, NULL };
	char tmp[HOSTFS_BUFSIZE], *file;

	err = os_stat_file(jail_dir, &jail_inode);
	if(err)
		goto out;

	save_pwd = os_open_file(".", of_read(OPENFLAGS()), 0);
	if(save_pwd < 0)
		goto out;

	file = get_path(path, tmp, sizeof(tmp));
	if(file == NULL)
		goto out_close;

	err = os_change_dir(file);
	if(err)
		goto out_free;

	err = os_stat_file(".", &cur_dir);
	if(err)
		goto out_back;

	do {
		if(SAME_INO(cur_dir, jail_inode)){
			escaping = 0;
			break;
		}

		err = os_change_dir("..");
		if(err)
			goto out_back;

		last_dir = cur_dir;

		err = os_stat_file(".", &cur_dir);
		if(err)
			goto out_back;

	} while(!SAME_INO(last_dir, cur_dir));

	err = os_fchange_dir(save_pwd);
	if(err)
		goto out_close;

	free_path(file, tmp);
	os_close_file(save_pwd);

	return escaping;

out_back:
	os_fchange_dir(save_pwd);
out_free:
	free_path(file, tmp);
out_close:
	os_close_file(save_pwd);
out:
	return err;
}


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
