Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <566449A3.6030504@digikod.net>
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
 <1448805802-12156-2-git-send-email-mic@digikod.net> <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
 <56641CEA.5080202@digikod.net> <566449A3.6030504@digikod.net>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Tue, 8 Dec 2015 15:37:39 -0500
Message-ID: <CADNZ+wTtu5gZuztSAnY9TE0fV4cVgqr534gyDUEkp0LS=Vq4Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 6 December 2015 at 09:43, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> Well, I'm concerned to use umask because it is not thread-safe and dr=
ivers may use create_mem_file() in a multi-theaded context.

You are right. We should perhaps set the umask to 0700 permanently
during process start. But I am not sure if this will interfere with
other UML code.

> I prefer to stick to fchmod and handle the race-condition with O_TMPF=
ILE unsell someone is sure that this will not create bugs :)

The fchmod call is basically useless and should probably be removed.
Even mmap only checks the file descriptor, not the file permissions. I
have pasted a test program below if you wish to confirm. AFAICT
changing the permissions after file deletion accomplishes nothing
unless the attacker bizarrely chooses to hard-link the file during the
race instead of opening it.

#include <assert.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char **argv) {
  int fd =3D open("./foo", O_RDWR|O_CREAT|O_EXCL, 0700);
  assert(fd >=3D 0);
  int ret =3D write(fd, "bar\n", 4);
  assert(ret =3D=3D 4);
  ret =3D fchmod(fd, 0400);
  assert(ret >=3D 0);
  char *buf =3D mmap(0, 4, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, =
fd, 0);
  assert(buf);
  buf[2] =3D 'z';
  ret =3D munmap(buf, 4);
  assert(ret >=3D 0);
  return 0;
}
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

