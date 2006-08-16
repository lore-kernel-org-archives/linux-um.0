Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GDIUM-0000Hf-Ab for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Aug 2006 03:19:06 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GDIUK-0000Yq-B5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Aug 2006 03:19:06 -0700
Received: by nf-out-0910.google.com with SMTP id l36so555832nfa
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Aug 2006 03:19:02 -0700 (PDT)
Message-ID: <39134b110608160319i50ea43d8kd955ef1405da939a@mail.gmail.com>
Date: Wed, 16 Aug 2006 18:19:01 +0800
From: "wang lianwei" <lianwei.wang@gmail.com>
In-Reply-To: <200608151947.54925.blaisorblade@yahoo.it>
MIME-Version: 1.0
References: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
	<200608122022.42389.blaisorblade@yahoo.it>
	<39134b110608140407n718d0cf5rfed71f8295ea43e0@mail.gmail.com>
	<200608151947.54925.blaisorblade@yahoo.it>
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
Content-Type: multipart/mixed; boundary="===============1640501755=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

--===============1640501755==
Content-Type: multipart/alternative; 
	boundary="----=_Part_235439_11416407.1155723541802"

------=_Part_235439_11416407.1155723541802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

yes, you are right. see this patches.


diff -urNp linux-2.6.10/fs/hostfs/hostfs.h linux-2.6.10-src
/fs/hostfs/hostfs.h
--- linux-2.6.10/fs/hostfs/hostfs.h      2006-04-12 15:12:51.000000000 +0800
+++ linux-2.6.10-src/fs/hostfs/hostfs.h   2006-08-16 15:58:59.149590168+0800
@@ -40,6 +40,7 @@ extern int access_file(char *path, int r
 extern int open_file(char *path, int r, int w, int append);
 extern int file_type(const char *path, int *maj, int *min);
 extern void *open_dir(char *path, int *err_out);
+extern void seek_dir(void *stream, unsigned long long pos);
 extern char *read_dir(void *stream, unsigned long long *pos,
                      unsigned long long *ino_out, int *len_out);
 extern void close_file(void *stream);



diff -urNp linux-2.6.10/fs/hostfs/hostfs_kern.c linux-2.6.10-src
/fs/hostfs/hostfs_kern.c
--- linux-2.6.10/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000 +0800
+++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c      2006-08-16 15:51:
08.105199800 +0800
@@ -338,6 +338,7 @@ int hostfs_readdir(struct file *file, vo
        kfree(name);
        if(dir == NULL) return(-error);
        next = file->f_pos;
+      seek_dir(dir, next);
        while((name = read_dir(dir, &next, &ino, &len)) != NULL){
                error = (*filldir)(ent, name, len, file->f_pos,
                                   ino, DT_UNKNOWN);



diff -urNp linux-2.6.10/fs/hostfs/hostfs_user.c linux-2.6.10-src
/fs/hostfs/hostfs_user.c
--- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000 +0800
+++ linux-2.6.10-src/fs/hostfs/hostfs_user.c      2006-08-16 15:53:
31.618382480 +0800
@@ -116,13 +116,19 @@ void *open_dir(char *path, int *err_out)
        return(dir);
 }

+void seek_dir(void *stream, unsigned long long pos)
+{
+        DIR *dir = stream;
+
+        seekdir(dir, pos);
+}
+
 char *read_dir(void *stream, unsigned long long *pos,
               unsigned long long *ino_out, int *len_out)
 {
        DIR *dir = stream;
        struct dirent *ent;

-       seekdir(dir, *pos);
        ent = readdir(dir);
        if(ent == NULL) return(NULL);
        *len_out = strlen(ent->d_name);





2006/8/16, Blaisorblade <blaisorblade@yahoo.it>:
>
> On Monday 14 August 2006 13:07, wang lianwei wrote:
> > Answers:
> >
> > 1. I test it on ext3 filesystem.
> >
> > 2. You are right. Sometimes the pos telldir returned is not the next
> entry
> > offset. just as your point out:
> >       position 0 -> readdir "." -> you call telldir -> it _again_ says
> > you're at 0.
> >
> > 3. I also try to resolve it by remove the seekdir(only use the
> > sequence readdir call), It is also worked.
>
> I can guess what the patch does but please generate with the additional -p
> option so it's easier to read (otherwise the recipient _has_ to read the
> source). Compliments for the solution, it's really simpler and better than
> my
> proposal.
>
> Also, you have to regenerate it anyway for another (tiny) reason: it is
> not
> always safe to use "seekdir" in kernelspace code, you need (sadly) a new
> wrapper in hostfs_user.c and to call it instead of seekdir in
> hostfs_kern.c;
> almost surely you'll get an "undeclared function" warning but
> miscompilations
> in some rare cases are also possible, say for stat(): it is defined almost
> only as a static inline function, or for some structures having different
> definitions in userspace and kernelspace.
>
> > --- linux-2.6.x/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000+0800
> > +++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c      2006-08-14 18:25:
> > 13.772237744 +0800
> > @@ -338,6 +338,7 @@
> >         kfree(name);
> >         if(dir == NULL) return(-error);
> >         next = file->f_pos;
> > +       seekdir(dir,next);
> >         while((name = read_dir(dir, &next, &ino, &len)) != NULL){
> >                 error = (*filldir)(ent, name, len, file->f_pos,
> >                                    ino, DT_UNKNOWN);
> >
> >
> > --- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000+0800
> > +++ linux-2.6.10-src/fs/hostfs/hostfs_user.c      2006-08-14 18:36:
> > 24.276305632 +0800
> > @@ -122,7 +122,6 @@
> >         DIR *dir = stream;
> >         struct dirent *ent;
> >
> > -       seekdir(dir, *pos);
> >         ent = readdir(dir);
> >         if(ent == NULL) return(NULL);
> >         *len_out = strlen(ent->d_name);
>
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade
> http://www.user-mode-linux.org/~blaisorblade
> Chiacchiera con i tuoi amici in tempo reale!
> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com
>
>

------=_Part_235439_11416407.1155723541802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>yes, you are right. see this patches.</div>
<div>&nbsp;</div>
<div>
<p>diff -urNp linux-2.6.10/fs/hostfs/hostfs.h linux-2.6.10-src/fs/hostfs/hostfs.h<br>--- linux-2.6.10/fs/hostfs/hostfs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-04-12 15:12:51.000000000 +0800<br>+++ linux-2.6.10-src/fs/hostfs/hostfs.h&nbsp;&nbsp; 2006-08-16 15:58:
59.149590168 +0800<br>@@ -40,6 +40,7 @@ extern int access_file(char *path, int r<br>&nbsp;extern int open_file(char *path, int r, int w, int append);<br>&nbsp;extern int file_type(const char *path, int *maj, int *min);<br>&nbsp;extern void *open_dir(char *path, int *err_out);
<br>+extern void seek_dir(void *stream, unsigned long long pos);<br>&nbsp;extern char *read_dir(void *stream, unsigned long long *pos,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long long *ino_out, int *len_out);<br>&nbsp;extern void close_file(void *stream);
<br>&nbsp;<br>&nbsp;</p>
<p>diff -urNp linux-2.6.10/fs/hostfs/hostfs_kern.c linux-2.6.10-src/fs/hostfs/hostfs_kern.c<br>--- linux-2.6.10/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000 +0800<br>+++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-08-16 15:51:
08.105199800 +0800<br>@@ -338,6 +338,7 @@ int hostfs_readdir(struct file *file, vo<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(name);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(dir == NULL) return(-error);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = file-&gt;f_pos;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;seek_dir(dir, next);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while((name = read_dir(dir, &amp;next, &amp;ino, &amp;len)) != NULL){
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error = (*filldir)(ent, name, len, file-&gt;f_pos,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ino, DT_UNKNOWN);<br>&nbsp;<br>&nbsp;</p>
<p>diff -urNp linux-2.6.10/fs/hostfs/hostfs_user.c linux-2.6.10-src/fs/hostfs/hostfs_user.c<br>--- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000 +0800<br>+++ linux-2.6.10-src/fs/hostfs/hostfs_user.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-08-16 15:53:
31.618382480 +0800<br>@@ -116,13 +116,19 @@ void *open_dir(char *path, int *err_out)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(dir);<br>&nbsp;}<br>&nbsp;<br>+void seek_dir(void *stream, unsigned long long pos)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIR *dir = stream;<br>+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir, pos);<br>+}<br>+<br>&nbsp;char *read_dir(void *stream, unsigned long long *pos,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long long *ino_out, int *len_out)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIR *dir = stream;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dirent *ent;
<br>&nbsp;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir, *pos);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = readdir(dir);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(ent == NULL) return(NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *len_out = strlen(ent-&gt;d_name);</p><br>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">2006/8/16, Blaisorblade &lt;<a href="mailto:blaisorblade@yahoo.it">blaisorblade@yahoo.it</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Monday 14 August 2006 13:07, wang lianwei wrote:<br>&gt; Answers:<br>&gt;<br>&gt; 1. I test it on ext3 filesystem.
<br>&gt;<br>&gt; 2. You are right. Sometimes the pos telldir returned is not the next entry<br>&gt; offset. just as your point out:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; position 0 -&gt; readdir &quot;.&quot; -&gt; you call telldir -&gt; it _again_ says
<br>&gt; you're at 0.<br>&gt;<br>&gt; 3. I also try to resolve it by remove the seekdir(only use the<br>&gt; sequence readdir call), It is also worked.<br><br>I can guess what the patch does but please generate with the additional -p
<br>option so it's easier to read (otherwise the recipient _has_ to read the<br>source). Compliments for the solution, it's really simpler and better than my<br>proposal.<br><br>Also, you have to regenerate it anyway for another (tiny) reason: it is not
<br>always safe to use &quot;seekdir&quot; in kernelspace code, you need (sadly) a new<br>wrapper in hostfs_user.c and to call it instead of seekdir in hostfs_kern.c;<br>almost surely you'll get an &quot;undeclared function&quot; warning but miscompilations
<br>in some rare cases are also possible, say for stat(): it is defined almost<br>only as a static inline function, or for some structures having different<br>definitions in userspace and kernelspace.<br><br>&gt; --- linux-2.6.x
/fs/hostfs/hostfs_kern.c 2006-04-12 15:12:51.000000000 +0800<br>&gt; +++ linux-2.6.10-src/fs/hostfs/hostfs_kern.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2006-08-14 18:25:<br>&gt; 13.772237744 +0800<br>&gt; @@ -338,6 +338,7 @@<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(dir == NULL) return(-error);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = file-&gt;f_pos;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir,next);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while((name = read_dir(dir, &amp;next, &amp;ino, &amp;len)) != NULL){<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error = (*filldir)(ent, name, len, file-&gt;f_pos,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ino, DT_UNKNOWN);<br>&gt;<br>&gt;<br>&gt; --- linux-2.6.x/fs/hostfs/hostfs_user.c 2006-04-12 15:12:52.000000000 +0800<br>&gt; +++ linux-2.6.10-src/fs/hostfs/hostfs_user.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2006-08-14 18:36:
<br>&gt; 24.276305632 +0800<br>&gt; @@ -122,7 +122,6 @@<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DIR *dir = stream;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dirent *ent;<br>&gt;<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seekdir(dir, *pos);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = readdir(dir);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(ent == NULL) return(NULL);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *len_out = strlen(ent-&gt;d_name);<br><br>--<br>Inform me of my mistakes, so I can keep imitating Homer Simpson's &quot;Doh!&quot;.<br>Paolo Giarrusso, aka Blaisorblade<br><a href="http://www.user-mode-linux.org/~blaisorblade">
http://www.user-mode-linux.org/~blaisorblade</a><br>Chiacchiera con i tuoi amici in tempo reale!<br><a href="http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com">http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com
</a><br><br></blockquote></div><br>

------=_Part_235439_11416407.1155723541802--


--===============1640501755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1640501755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1640501755==--
