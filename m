Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/9] UML vector network driver: Adjustments for three function
 implementations
Message-ID: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:15:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:06:16 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (9):
  Delete unnecessary code in user_init_raw_fds()
  Less checks in user_init_raw_fds() after error detection
  Adjust an error message in user_init_socket_fds()
  Delete an unnecessary check before kfree() in user_init_socket_fds()
  Delete two unnecessary checks before freeaddrinfo() in user_init_socket_fds()
  Less checks in user_init_socket_fds() after error detection
  Adjust an error message in user_init_tap_fds()
  Less checks in user_init_tap_fds() after error detection
  Delete an unnecessary variable initialisation in user_init_tap_fds()

 arch/um/drivers/vector_user.c | 133 +++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 73 deletions(-)

-- 
2.16.2


