Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgVHS-0006Go-MW	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 15:13:42 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DgVHR-0007C2-Pp	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 15:13:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id B151EAEF83
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  9 Jun 2005 22:34:17 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05248-11 for <user-mode-linux-devel@lists.sourceforge.net>;
 Thu,  9 Jun 2005 22:34:14 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.90.211])
	by mail.nagafix.co.uk (Postfix) with ESMTP id CC789AEF82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  9 Jun 2005 22:34:13 +0100 (BST)
Subject: [Fwd: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing]
From: antoine <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1118355886.10190.158.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 09 Jun 2005 23:24:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net

-------- Forwarded Message --------
> From: Stephen Smalley <sds@tycho.nsa.gov>
> To: antoine <antoine@nagafix.co.uk>
> Cc: SELinux <selinux@tycho.nsa.gov>, Blaisorblade
> <blaisorblade@yahoo.it>
> Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
> Date: Thu, 09 Jun 2005 15:45:49 -0400
> On Thu, 2005-06-09 at 19:04 +0100, antoine wrote:
> > > UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file to 
> > > work, and so it tries doing this very early, to give the user a hint on what 
> > > happens. On a fs mounted noexec this is forbidden, so possibly it's forbidden 
> > > also by SELinux; however, it would be nicer if SELinux could simply allow 
> > > mmap()ing with PROT_EXEC without allowing file execution...; allowing mmap() 
> > > does not put a big hole inside protections while allowing file execution 
> > > does...means that if the user can supply a program to execute, that program 
> > > can be written to mmap() and execute code from /tmp, but at that point the 
> > > intruder could simply execute his code.
> > 
> > Can anyone answer this for us please?
> > I am trying to workaround this:
> > audit(1117846877.640:0): avc:  denied  { execute } for  pid=29031 comm=um-kernel path=/tmp/vm_file-NnIm5X (deleted) dev=md7 ino=3965039 scontext=root:sysadm_r:um_kernel_t tcontext=root:object_r:um_tmp_t tclass=file
> > Without giving uml execute access to its tmp directory.
> 
> Possibly the UML folks could elaborate on what UML is trying to do here?
> In the long term, I'd advise changing its behavior if possible, as
> allowing execution of arbitrary code is obviously undesirable and use
> of /tmp will break noexec /tmp mounts as noted above regardless of what
> SELinux does.
> 
> In the short term, you naturally have the option of adding:
> 	allow um_kernel_t um_tmp_t:file execute;
> to your policy as a workaround.  This shouldn't actually allow direct
> execve() of such files, as that would also trigger another check
> (execute_no_trans if staying in the same domain or entrypoint
> otherwise), but would allow indirect execution via ld.so (if staying in
> the same domain).




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
