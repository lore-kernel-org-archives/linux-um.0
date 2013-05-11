Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ub7zX-0001Q6-Cm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 11:29:31 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub7zW-0007BN-Ii
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 11:29:31 +0000
Received: by mail-wi0-f178.google.com with SMTP id hm14so1414919wib.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 04:29:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130511140139.1e6ee40b@sf>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
	<CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
	<518E14B7.3030409@gmx.de> <20130511140139.1e6ee40b@sf>
Date: Sat, 11 May 2013 13:29:23 +0200
Message-ID: <CAFLxGvyYRBspKZiqOe+NSW+B_02oS3TVH9WM9nXBDRiDdKjTRA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Fwd: Re: [uml-user] WARNING: at
	mm/slab_common.c:376 kmalloc_slab+0x33/0x80()
To: Sergei Trofimovich <slyich@gmail.com>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Dave Jones <davej@redhat.com>

On Sat, May 11, 2013 at 1:01 PM, Sergei Trofimovich <slyich@gmail.com> wrote:
>> With this change:
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 7b1ca9b..289211d 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2236,6 +2236,8 @@ int copy_mount_string(const void __user *data, char **where)
>>                 return 0;
>>         }
>>
>> +       printk(" here: size is %ul\n", (unsigned long)data);
>
> Be careful, it's long->int truncation. I guess you want '%lu' instead of '%ul'.

Erm, data is a character array...

--
Thanks,
//richard

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

