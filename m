Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4DD68EDF.4030301@linux.intel.com>
Date: Fri, 20 May 2011 08:55:11 -0700
From: Darren Hart <dvhart@linux.intel.com>
MIME-Version: 1.0
References: <201105191526.31904.toralf.foerster@gmx.de>	<201105192218.18261.toralf.foerster@gmx.de>	<20110519204342.GA10792@home.goodmis.org>	<201105200937.15322.toralf.foerster@gmx.de> <BANLkTik0oz6ppJvRpufaaiBL1pqcAxNHuA@mail.gmail.com>
In-Reply-To: <BANLkTik0oz6ppJvRpufaaiBL1pqcAxNHuA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 05/20/2011 12:56 AM, richard -rw- weinberger wrote:
> 2011/5/20 Toralf F=F6rster <toralf.foerster@gmx.de>:
>> ...
>> Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x80a9=
f6b
>=20
> Looks like a NULL-pointer bug.
> What code is at address 80a9f6b?
> Use "objdump -d -S | less" to find it.
> Please note, kernel binary and log message have to match!
>=20
>> The file /var/log/messages of the UML says :
>>
>> 2011-05-20T09:33:03.455+02:00 n22_uml kernel: ------------[ cut here=
 ]------------
>> 2011-05-20T09:33:03.455+02:00 n22_uml kernel: WARNING: at kernel/fut=
ex.c:789 wake_futex+0x28/0x60()
>=20
> Is this really 2.6.39?
> Line 789 contains no WARN*().
> http://lxr.linux.no/#linux+v2.6.39/kernel/futex.c#L789
>=20

I suspect Toralf is hitting the WARN_ON in __unqueue_futex:

	if (WARN_ON(!q->lock_ptr || !spin_is_locked(q->lock_ptr)
			|| plist_node_empty(&q->list)))

Toralf, can you instrument that let us know which of conditions is
triggering the WARN_ON? Something like the following should be adequate
to get you the line number. I suspect it is plist_node_empty give the
git bisect results you reported.


diff --git a/kernel/futex.c b/kernel/futex.c
index abd5324..7f31bca 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -782,8 +782,11 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;

-	if (WARN_ON(!q->lock_ptr || !spin_is_locked(q->lock_ptr)
-			|| plist_node_empty(&q->list)))
+	if (WARN_ON(!q->lock_ptr))
+		return;
+	if (!spin_is_locked(q->lock_ptr))
+		return;
+	if (plist_node_empty(&q->list))
 		return;

 	hb =3D container_of(q->lock_ptr, struct futex_hash_bucket, lock);




--=20
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

