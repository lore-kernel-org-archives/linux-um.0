Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
 <1448746350-19998-2-git-send-email-mic@digikod.net> <565A1F49.3040408@nod.at>
 <565A3035.6030104@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <565A30DB.1070902@nod.at>
Date: Sat, 28 Nov 2015 23:55:23 +0100
MIME-Version: 1.0
In-Reply-To: <565A3035.6030104@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] um: Set secure access mode for temporary file
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 28.11.2015 um 23:52 schrieb Micka=C3=ABl Sala=C3=BCn:
>=20
> On 28/11/2015 22:40, Richard Weinberger wrote:
>> Am 28.11.2015 um 22:32 schrieb Micka=C3=ABl Sala=C3=BCn:
>>> Replace the default insecure mode 0777 with 0700 for temporary file=
=2E
>>>
>>> Prohibit other users to change the executable mapped code.
>>
>> Hmm, isn't the tmp file already unlinked at this stage?
>>
>=20
> Yes, but if someone could open it before the unlink e.g. because of t=
he umask (which does not seems to be the case thanks to mkstemp, but re=
mains unspecified [1]), this user should then be able to have write acc=
ess to the file descriptor/description.

Yes, someone can open it before the unlink. But you change the file mod=
e after that.
How does it improve the situation? The attacker has already the file ha=
ndle.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

