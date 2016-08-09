Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Aug 2016 10:35:28 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 0/3] Fix seccomp for UM (next)
In-Reply-To: <1470085317-11932-1-git-send-email-mic@digikod.net>
Message-ID: <alpine.LRH.2.20.1608091035060.31071@namei.org>
References: <alpine.LRH.2.20.1608011053430.15475@namei.org> <1470085317-11932-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-938110433-1470702928=:31071"
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-938110433-1470702928=:31071
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 1 Aug 2016, Mickaël Salaün wrote:

> Hi,
> 
> This series fix the recent seccomp update for the User-mode Linux architecture
> (32-bit and 64-bit) since commit 26703c636c1f ("um/ptrace: run seccomp after
> ptrace") which close the hole where ptrace can change a syscall out from under
> seccomp.
> 
> Changes since v1:
> * fix commit message typo [2/3]
> * add Kees Cook's Acked-by
> * rebased on commit 7616ac70d1bb ("apparmor: fix SECURITY_APPARMOR_HASH_DEFAULT
>   parameter handling")

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next



-- 
James Morris
<jmorris@namei.org>

--1665246916-938110433-1470702928=:31071--

