Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9KuC-0002BN-An for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 02:56:20 -0700
Received: from 62-15-145-252.inversas.jazztel.es ([62.15.145.252]
	helo=saturno.agora-2000.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1C9KuB-0007rW-3S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 02:56:19 -0700
Subject: Re: [uml-devel] Read method for /proc/mconsole
Message-ID: <pCsceCsl.1095674170.7383030.galan@agora-2000.com>
In-Reply-To: <200409172108.28345.blaisorblade_spam@yahoo.it>
From: "=?ISO-8859-1?Q?Ferm=EDn?= =?ISO-8859-1?Q?Gal=E1n?="
	<fermin.galan@agora-2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Mon, 20 Sep 2004 11:56:10 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
To: blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net
Cc: "vnuml-devel@lists.dit.upm.es" <vnuml-devel@mail.dit.upm.es>


>> I'm working in the arch/um/drivers/mconsole_kern.c code in order to
>> implement a reading method for /proc/mconsole that allows me to send by
>> the "notify" socket in the host and receive in /proc/mconsole (exactly
>> the opposite to the current /proc/mconsole -> notify sockect mechanism).
>
>> In create_proc_mconsole I've changed the ent->read_proc from 'NULL' to
>> a handle function, read_proc_mconsole
>>
>>    ent->read_proc =3D read_proc_mconsole;
>
>> My problem now is how to implement read_proc_mconsole:
>
>> static int read_proc_mconsole(char *page, char **start, off_t off,
>>                               int count, int *eof, void *data)
>> {
>>    ...
>> }
>>
>> The problems that I'm facing are:
>
>> - I've found out the right header for the function in
>> include/linux/proc_fs.h (the read_proc_t typedef), but I don't know
>> what the arguments means and I wasn't able to find documentation about
>> it. Anyone can give a pointer to this information?
>
>Linux Device Drivers, 2nd Ed: - it contains a detailed explaination of tha=
t=20
>function (which has a very weird API):
>
>http://www.xml.com/ldd/chapter/book/index.html

Thank you! It seems a very useful reference about drivers and Linux kernel
in general. I'll have a deep look at it.

>> - The nofity socket descriptor is hold in the notify_socket global
>> variable, set up in mconsole_setup function. It seems that for pushing
>> information to the socket, the mconsole_notify method is called (defined
>> in mconsole_user.c). What function should I use to pull information from
>> the socket?
>
>Note: I've read your message quickly, so I'm not sure.
>On the host? In mconsole_user.c there are some wrappers to call recv*() an=
d=20
>send*() (or something such).

Maybe I should explain my purpose in detail. The idea is running a process
in the host that creates a socket (as the current notify.pl does). This
socket is used as parameter in the 'notify=3D' kernel switch when booting
the UML. With the current event notification mechanism, a /proc/mconsole
appears in the UML filesystem, so UML processes can write to
/proc/mconsole
(the simple 'cat hello > /proc/mconsole', for example) and the host
process
linked to the socket (notify.pl, for example) receives it.

I would like to go a steep further: if the host process writes to
socket then a UML process reading from /proc/mconsole receives it.

My aim (maybe weird :) is to implement a complete UML-host communication
mechanism (that doesn't use virtual networking). Why don't use virtual
networking? Well, the network is not always present in all UML use
scenarios,
and, when present, it may have some problems (for example, high latency in
messages).

>In this case, you should patch mconsole_get_request, to understand also th=
e=20
>requests you are going to send. However, the host must use a special=20
>request, or mconsole will get confused - otherwise, if this is not possibl=
e=20
>for you, you might create a new socket on the host just for this purpose=20
>(note that IIRC you cannot anyway use "cat " on the host socket, even if I=
=20
>have 0 experience with sockets).

Is the mconsole_get_request code the handle (in UML kernel) when a
command is send using uml_mconsole?

If so, an alternative to the mechanism described before (host user
process ->
UML user process, through /proc/mconsole) that when the host process
writes
to the socket, "someting" in the UML kernel (a driver?) receives it and
process is, maybe launching user processes (which is the the API so
drivers
can launch user processes?). That is: host user process -> UML kernel
handle
code. If I understand correctly, the uml_mconole seems to work this way.

Any help you can provide is very useful to me, because I haven't ever
deal
with the dreadful kernel code before and I'm feeling a bit lost with all
these cryptic C statements around me :)

Thank you!

------
Ferm=EDn


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
