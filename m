Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448805802-12156-2-git-send-email-mic@digikod.net>
References: <1448805802-12156-1-git-send-email-mic@digikod.net> <1448805802-12156-2-git-send-email-mic@digikod.net>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Fri, 4 Dec 2015 12:13:12 -0500
Message-ID: <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

File permissions are checked at time of open, so I think this fchmod
call has never had any effect.

If there is a concern that the mkstemp implementation may be insecure,
why not set and restore the umask?
