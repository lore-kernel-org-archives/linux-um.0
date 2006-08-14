Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCaHo-0004RO-PX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 04:07:12 -0700
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GCaHm-0008Ks-Lw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 04:07:12 -0700
Received: by nf-out-0910.google.com with SMTP id a27so27428nfc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Aug 2006 04:07:08 -0700 (PDT)
Message-ID: <39134b110608140407n718d0cf5rfed71f8295ea43e0@mail.gmail.com>
Date: Mon, 14 Aug 2006 19:07:08 +0800
From: "wang lianwei" <lianwei.wang@gmail.com>
In-Reply-To: <200608122022.42389.blaisorblade@yahoo.it>
MIME-Version: 1.0
References: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
	<200608122022.42389.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML hostfs bugs
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1325291242=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1325291242==
Content-Type: multipart/alternative; 
	boundary="----=_Part_166800_23667354.1155553628045"

------=_Part_166800_23667354.1155553628045
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Answers:

1. I test it on ext3 filesystem.

2. You are right. Sometimes the pos telldir returned is not the next entry
offset. just as your point out:
      position 0 -> readdir "." -> you call telldir -> it _again_ says
you're at 0.

3. I also try to resolve it by remove the seekdir(only use the
sequence readdir call), It is also worked.

--- linux-2.6.x/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000 +0800
+++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c      2006-08-14 18:25:
13.772237744 +0800
@@ -338,6 +338,7 @@
        kfree(name);
        if(dir == NULL) return(-error);
        next = file->f_pos;
+       seekdir(dir,next);
        while((name = read_dir(dir, &next, &ino, &len)) != NULL){
                error = (*filldir)(ent, name, len, file->f_pos,
                                   ino, DT_UNKNOWN);


--- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000 +0800
+++ linux-2.6.10-src/fs/hostfs/hostfs_user.c      2006-08-14 18:36:
24.276305632 +0800
@@ -122,7 +122,6 @@
        DIR *dir = stream;
        struct dirent *ent;

-       seekdir(dir, *pos);
        ent = readdir(dir);
        if(ent == NULL) return(NULL);
        *len_out = strlen(ent->d_name);




2006/8/13, Blaisorblade <blaisorblade@yahoo.it>:
>
> On Thursday 10 August 2006 17:42, wang lianwei wrote:
> > Hi all,
> >
> > There is a bug with UML kernel, some host directory can not be read, for
>
> > example "ls /mnt/host/usr/lib", this command is dead until you press
> > CTRL+c. I test it with Redhat Enterprise Linux 4.
>
> Yes, this has been reported various times but difficult to reproduce, so
> we're
> very happy somebody diagnosed it, and I'd be interested in understanding
> it
> better.
>
> On which filesystem (ext3, reiserfs, what else) lays /usr/lib on the host?
>
> This is because the UML read host directory through opendir, seekdir,
> > readdir and telldir. When get the dir stream offset through telldir, it
> > always return 0 on some directory, for example".",
>
> Can you elaborate on this? (And if possible post some details, like a
> strace)
>
> What I've understood is:
>
> position 0 -> you read "." -> you call telldir -> it _again_ says you're
> at 0?
>
> I can maybe understand why it could happen. I'd be more interested in
> checking
> if a simple sequence of readdir() calls (without seekdir()) would work
> (probably write a standalone test program, it will be easier to use and
> debug) and why read_dir needs to do seekdir (I think it's done to handle
> calls to seekdir by the underlying process, but there should be different
> ways to do it).
>
> > I don't know why? But
> > we can fix it as follows although the next dir entry offset is not
> exact:
>
> > Modify the fs/hostfs/hostfs_user.c file, update the read_dir function,
> >
> > char *read_dir(void *stream, unsigned long long *pos,
> >                unsigned long long *ino_out, int *len_out)
> > {
> >         DIR *dir = stream;
> >         struct dirent *ent;
> >         unsigned long long oldpos;
> >
> >         oldpos = *pos;
> >
> >         seekdir(dir, *pos);
> >         ent = readdir(dir);
> >         if(ent == NULL)
> >         {
> >                 return(NULL);
> >         }
> >         *len_out = strlen(ent->d_name);
> >         *ino_out = ent->d_ino;
> >         *pos = telldir(dir);
> >
> >         /* Fix the telldir return 0 error */
> >         if (*pos == 0)
> >                 *pos = oldpos + *len_out;
> >
> >         return(ent->d_name);
> > }
> >
> > although the next offset is not exact, but the readdir can get the next
> > entry correct.
>
> This probably depends heavily on the underlying filesystem...
>
> > Can anyone give a better solution?
>
> I can't yet, but maybe with your help we'll be able.
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade
> http://www.user-mode-linux.org/~blaisorblade
> Chiacchiera con i tuoi amici in tempo reale!
> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com
>
>

------=_Part_166800_23667354.1155553628045
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Answers:</div>
<div>&nbsp;</div>
<div>1. I test it on ext3 filesystem.</div>
<div><br>2. You are right. Sometimes the&nbsp;pos telldir returned is&nbsp;not the next entry offset.&nbsp;just&nbsp;as your point out:</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; position 0 -&gt; readdir &quot;.&quot; -&gt; you call telldir -&gt; it _again_ says you're at 0.&nbsp;</div>
<div>&nbsp;</div>
<div>3. I also try to resolve&nbsp;it by remove the seekdir(only use the sequence&nbsp;readdir call), It is also worked.</div>
<div>&nbsp;</div>
<div>--- linux-2.6.x/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000 +0800<br>+++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-08-14 18:25:13.772237744 +0800</div>
<div>@@ -338,6 +338,7 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(name);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(dir == NULL) return(-error);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = file-&gt;f_pos;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir,next);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while((name = read_dir(dir, &amp;next, &amp;ino, &amp;len)) != NULL){
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error = (*filldir)(ent, name, len, file-&gt;f_pos,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ino, DT_UNKNOWN);<br>&nbsp;</div>
<div>
<p>--- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000 +0800<br>+++ linux-2.6.10-src/fs/hostfs/hostfs_user.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-08-14 18:36:24.276305632 +0800<br>@@ -122,7 +122,6 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIR *dir = stream;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dirent *ent;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir, *pos);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = readdir(dir);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(ent == NULL) return(NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *len_out = strlen(ent-&gt;d_name);</p></div>
<div><br>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><span class="gmail_quote">2006/8/13, Blaisorblade &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:blaisorblade@yahoo.it" target="_blank">blaisorblade@yahoo.it</a>&gt;:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thursday 10 August 2006 17:42, wang lianwei wrote:<br>&gt; Hi all,<br>&gt;<br>&gt; There is a bug with UML kernel, some host directory can not be read, for 
<br>&gt; example &quot;ls /mnt/host/usr/lib&quot;, this command is dead until you press<br>&gt; CTRL+c. I test it with Redhat Enterprise Linux 4.<br><br>Yes, this has been reported various times but difficult to reproduce, so we're 
<br>very happy somebody diagnosed it, and I'd be interested in understanding it<br>better.<br><br>On which filesystem (ext3, reiserfs, what else) lays /usr/lib on the host?<br></blockquote>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; This is because the UML read host directory through opendir, seekdir, <br>&gt; readdir and telldir. When get the dir stream offset through telldir, it
<br>&gt; always return 0 on some directory, for example&quot;.&quot;,<br><br>Can you elaborate on this? (And if possible post some details, like a strace) <br><br>What I've understood is:<br><br>position 0 -&gt; you read &quot;.&quot; -&gt; you call telldir -&gt; it _again_ says you're at 0?
<br><br>I can maybe understand why it could happen. I'd be more interested in checking <br>if a simple sequence of readdir() calls (without seekdir()) would work<br>(probably write a standalone test program, it will be easier to use and
<br>debug) and why read_dir needs to do seekdir (I think it's done to handle <br>calls to seekdir by the underlying process, but there should be different<br>ways to do it).<br><br>&gt; I don't know why? But<br>&gt; we can fix it as follows although the next dir entry offset is not exact:
<br><br>&gt; Modify the fs/hostfs/hostfs_user.c file, update the read_dir function, <br>&gt;<br>&gt; char *read_dir(void *stream, unsigned long long *pos,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned long long *ino_out, int *len_out)<br>
&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIR *dir = stream;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dirent *ent;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long long oldpos;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oldpos = *pos;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir, *pos);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = readdir(dir);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(ent == NULL)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(NULL); <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *len_out = strlen(ent-&gt;d_name);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ino_out = ent-&gt;d_ino;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pos = telldir(dir);
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fix the telldir return 0 error */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*pos == 0) <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pos = oldpos + *len_out;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(ent-&gt;d_name);<br>&gt; }<br>&gt;<br>&gt; although the next offset is not exact, but the readdir can get the next
<br>&gt; entry correct.<br><br>This probably depends heavily on the underlying filesystem...<br><br>&gt; Can anyone give a better solution?<br><br>I can't yet, but maybe with your help we'll be able.<br>--<br>Inform me of my mistakes, so I can keep imitating Homer Simpson's &quot;Doh!&quot;. 
<br>Paolo Giarrusso, aka Blaisorblade<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.user-mode-linux.org/~blaisorblade" target="_blank">http://www.user-mode-linux.org/~blaisorblade</a><br>Chiacchiera con i tuoi amici in tempo reale!
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com" target="_blank">http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com</a><br><br>
</blockquote></div><br>

------=_Part_166800_23667354.1155553628045--


--===============1325291242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1325291242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1325291242==--
